require_relative 'common_standards_download'
require_relative 'common_standards_import'
require 'standalone_migrations'

ActiveRecord::SchemaMigration.class_eval do
  def self.table_name
    'standards_schema_migrations'
  end
end

StandaloneMigrations::Tasks.load_tasks

task :default => :import

desc ""
task :import, [:limit] => :fetch do
  puts 'import'
  ENV["ENV"] ||= "development"
  CommonStandardsImport.run('jurisdictions.json', 'standard_sets.json', true)
  CommonStandardsImport.count_children
end

task :custom do
  puts 'importing custom'
  ENV["ENV"] ||= "development"
  raise "provide a name for this custom standards set by setting JUR_TITLE" unless ENV["JUR_TITLE"]
  raise "provide a source directory by setting SRC_DIR" unless ENV["SRC_DIR"]
  CommonStandardsImport.import_custom(ENV["JUR_TITLE"], ENV["SRC_DIR"])
end

task :count do
  CommonStandardsImport.count_children
end

task :fetch, [:limit] => :clean do |t, args|
  if args[:limit]
    limit = args[:limit].to_i
  end
  CommonStandardsDownload.run("vZKoJwFB1PTJnozKBSANADc3", limit)
  puts 'fetch complete'
end

task :clean do
  ['jurisdictions.json', 'standard_sets.json', 'standards.json'].each do |fname|
    if File.exists?(fname)
      File.delete(fname)
    end
  end
end
