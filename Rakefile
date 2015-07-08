require_relative 'common_standards_download'
require 'standalone_migrations'

StandaloneMigrations::Tasks.load_tasks

task :default => :import

desc ""
task :import, [:limit] => :fetch do
  puts 'import'
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
