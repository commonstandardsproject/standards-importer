require 'active_record'
require 'logger'

class Jurisdiction < ActiveRecord::Base
  self.inheritance_column = :_type_disabled
  has_many :standards
end

class Standard < ActiveRecord::Base
  belongs_to :jurisdiction
end

class CommonStandardsImport

  def self.run(jurisdictions_file, standards_file, wipe_existing=false)

    ActiveRecord::Base.logger = Logger.new('debug.log')
    configuration = YAML::load(IO.read('db/config.yml'))
    ActiveRecord::Base.establish_connection(configuration[ENV["ENV"]])



    importer = self.new
    importer.import_jurisdictions(jurisdictions_file)
    importer.import_standards(standards_file)
  end

  def import_jurisdictions(file)
    jurisdictions = JSON.parse(File.read(file))
    jurisdictions.each do |jur|
      Jurisdiction.create(
        title: jur["title"],
        csp_id: jur["id"],
        type: jur["type"],
        document: jur
      )
    end
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
