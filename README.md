# standards-importer

Usage:

* clone repo
* modify the Rakefile to use your own API key
* modify config.yml to fit your database config
* `bundle install`
* `rake`

If you wish to test without downloading the full set of standards, `rake import[3]` will limit to 3 jurisdictions and 3 sets per jurisdiction.
