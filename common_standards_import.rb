require 'active_record'
require 'logger'
require 'securerandom'
require 'digest/sha1'

class Jurisdiction < ActiveRecord::Base
  self.inheritance_column = :_type_disabled
  has_many :standards
end

class Standard < ActiveRecord::Base
  belongs_to :jurisdiction
end

class CommonStandardsImport

  def self.run(jurisdictions_file, standards_file, wipe_existing=false)
    ensure_setup
    importer = self.new
    importer.import_jurisdictions(jurisdictions_file)
    importer.import_standards(standards_file)
  end

  def self.initial_setup
    ActiveRecord::Base.logger = Logger.new('debug.log')
    configuration = YAML::load(IO.read('db/config.yml'))
    ActiveRecord::Base.establish_connection(configuration[ENV["ENV"]])
  end

  def self.ensure_setup
    unless @is_setup
      initial_setup
      @is_setup = true
    end
  end

  def self.count_children
    ensure_setup
    @tbl = Standard.table_name
    Standard.connection.execute("update #{@tbl} as st set child_count = cc.child_count from (select id, (select count(*) from #{@tbl} sc where sp.id = ANY(sc.parent_ids)) child_count from #{@tbl} sp) as cc where st.id = cc.id;")
  end

  def self.import_custom(title, source_dir)
    ensure_setup
    importer = self.new
    jur_hash = {
      "title" => title,
      "id" => SecureRandom.uuid,
      "type" => "private",
      "comment" => "Created by Standards Importer",
    }

    custom_jurisdiction = importer.create_jurisdiction(jur_hash)
    puts "created #{custom_jurisdiction.id}"
    importer.import_from_csv(custom_jurisdiction, source_dir)
    puts "successfully imported standards, new Jurisdiction id: #{custom_jurisdiction.id}"
  end

  def import_from_csv(jurisdiction, source_dir)
    files = Dir["#{source_dir}/*.csv"]
    puts files

    refresh_standards = []
    files.each do |file|
      puts "Importing #{file}"
      CSV.foreach(file, :headers => true) do |row|
        root_id = Digest::SHA1.hexdigest(jurisdiction.csp_id + row['Grade'] + row['Subject'])
        # puts row
        ed_levels = [row['Grade']]
        root = Standard.where(csp_id: root_id, jurisdiction: jurisdiction).first
        unless root
          root = Standard.create(
            jurisdiction: jurisdiction,
            csp_id: root_id,
            education_levels: ed_levels,
            title: "#{row['Subject']} #{row['Grade']}",
            document: {
              title: "#{row['Subject']} #{row['Grade']}",
              csp_id: root_id,
              description: "#{jurisdiction.title} - #{row['Subject']} #{row['Grade']}",
              subject: row['Subject']
            },
            subject: row['Subject'],
            indexed: false
          )
          puts "created root: #{root.title}"

        end

        refresh_standards.push(root.id)
        parent_ids = [root.id]

        if row['Topic']
          topic_id = Digest::SHA1.hexdigest(jurisdiction.csp_id + row['Grade'] + row['Subject'] + row['Topic'])
          topic = Standard.where(csp_id: topic_id, jurisdiction: jurisdiction).first
          unless topic
            topic = Standard.create(
              jurisdiction: jurisdiction,
              csp_id: topic_id,
              education_levels: ed_levels,
              title: "#{row['Topic']}",
              document: {
                title: "#{row['Topic']}",
                csp_id: topic_id,
                description: "#{jurisdiction.title} - #{row['Subject']}/#{row['Topic']} #{row['Grade']}",
                subject: row['Subject']
              },
              indexed: false,
              subject: row['Subject'],
              parent_ids: parent_ids
            )
            puts "Created Topic #{topic.title}"
          end
          refresh_standards.push(topic.id)
          parent_ids.push(topic.id)
        end

        if row['Subtopic']
          subtopic_id = Digest::SHA1.hexdigest(jurisdiction.csp_id + row['Grade'] + row['Subject'] + row['Topic'] + row['Subtopic'])
          subtopic = Standard.where(csp_id: subtopic_id, jurisdiction: jurisdiction).first
          unless subtopic
            subtopic = Standard.create(
              jurisdiction: jurisdiction,
              csp_id: subtopic_id,
              education_levels: ed_levels,
              title: "#{row['Subtopic']}",
              document: {
                title: "#{row['Subtopic']}",
                csp_id: subtopic_id,
                description: "#{jurisdiction.title} - #{row['Subject']}/#{row['Topic']}/#{row['Subtopic']} #{row['Grade']}",
                subject: row['Subject']
              },
              indexed: false,
              subject: row['Subject'],
              parent_ids: parent_ids
            )
            puts "Created subtopic #{subtopic.title}"
          end
          refresh_standards.push(subtopic.id)
          parent_ids.push(subtopic.id)
        end

        standard_id = Digest::SHA1.hexdigest(jurisdiction.csp_id + row['Grade'] + row['Subject'] + row['Topic'].to_s + row['Subtopic'].to_s + row['Description'].to_s)
        standard = Standard.where(csp_id: standard_id, jurisdiction: jurisdiction).first
        if standard
          puts "Duplicate standard! #{row['Description']}"
        else
          Standard.create(
            jurisdiction: jurisdiction,
            csp_id: standard_id,
            education_levels: ed_levels,
            title: "#{row['Description']}",
            document: {
              title: "#{row['Description']}",
              csp_id: standard_id,
              description: "#{row['Description']}",
              subject: row['Subject'],
              listId: row['Code']
            },
            indexed: true,
            subject: row['Subject'],
            parent_ids: parent_ids
          )
        end
      end
    end
    refresh_standards.each do |id|
      standard = Standard.find(id)
      standard.child_count = Standard.where("#{id} = ANY(parent_ids)").count
      standard.save!
    end
  end

  def import_jurisdictions(file)
    jurisdictions = JSON.parse(File.read(file))
    jurisdictions.each {|j| create_jurisdiction(j)}
  end

  def create_jurisdiction(jur)
    Jurisdiction.create(
      title: jur["title"],
      csp_id: jur["id"],
      type: jur["type"],
      document: jur
    )
  end

  def import_standards(file)
    standard_sets = JSON.parse(File.read(file))

    standard_sets.each do |set|
      ed_levels = set["educationLevels"]
      subject = set["subject"]
      child_standards = set.delete("standards")
      jurisdiction = Jurisdiction.where(csp_id: set["jurisdiction"]["id"]).first
      unless jurisdiction
        raise "Jurisdiction not found for #{set["id"]} #{set["title"]}"
      end
      #create root standard
      root = Standard.create(
        jurisdiction: jurisdiction,
        csp_id: set["id"],
        education_levels: ed_levels,
        title: set["title"],
        subject: subject,
        document: set
      )

      sorted_standards = child_standards.values.sort {|x,y| x["depth"] <=> y["depth"]}

      sorted_standards.each do |standard|
        most_parents = Standard.where(csp_id: standard["ancestorIds"]).sort {|x,y| x.parent_ids.length <=> y.parent_ids.length}
        parent_ids = [root.id] + most_parents.map(&:id)
        if parent_ids.length < standard["ancestorIds"].length + 1
          raise "parent not found"
        else
          create_from_json(standard, jurisdiction, ed_levels, subject, parent_ids)
        end
      end
    end
  end

  def create_from_json(standard, jurisdiction, ed_levels, subject, parent_ids)

    indexed = true
    if standard["statementLevel"]
      indexed = standard["statementLevel"] == "Standard"
    elsif standard["depth"] == 0
      indexed = false
    end

    Standard.create(
      jurisdiction: jurisdiction,
      csp_id: standard["id"],
      education_levels: ed_levels,
      subject: subject,
      document: standard,
      parent_ids: parent_ids,
      indexed: indexed
    )
  end

end
