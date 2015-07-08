require 'httparty'
require 'hashie'

class CommonStandardsDownload

  BASE_URL = 'http://api.commonstandardsproject.com/api/'

  def self.run(api_key, limit=nil)
    dl = self.new(api_key, limit)
    dl.fetch
  end

  def initialize(api_key, limit=nil)
    @api_key = api_key
    @limit = limit
    puts @limit
  end

  def fetch
    save_hash('jurisdictions', jurisdictions, ['standardSets'])
    save_hash('standard_sets', standard_sets, ['standards'])
    save_hash('standards', standards)
  end

  def standards
    result = []
    standard_sets.each do |set|
      i = 0
      set.standards.each_value do |val|
        if @limit
          i += 1
          break if i >= @limit
        end
        val.standard_set_id = set.id
        result.push(val)
      end
    end
    result
  end

  def jurisdictions
    @jurisdictions ||= load_jurisdictions
  end

  def standard_sets
    @standard_sets ||= load_standard_sets
  end

  def load_standard_sets
    result = []
    jurisdictions.each do |jur|
      puts "Fetching sets for #{jur.title}"
      jur.standardSets.each_with_index do |ss, i|
        break if @limit && i >= @limit
        result.push(auth_get('standard_sets/' + ss.id))
      end
    end

    result
  end

  def load_jurisdictions
    partials = auth_get('jurisdictions')

    result = []
    partials.each_with_index do |jur, i|
      break if @limit && i >= @limit

      if jur.id.is_a?(String)
        puts "Fetching jurisdiction #{jur.title}"
        result.push(auth_get('jurisdictions/' + jur.id))
      end
    end

    result
  end

  def save_hash(prefix, objects, strip_keys=[])

    clean_obj = objects.map { |o| o.reject { |k,v| strip_keys.include?(k) } }
    File.open(prefix + '.json', 'w') { |f| f.write(clean_obj.to_json) }
  end



  def auth_get(path, unwrap=true)
    resp = HTTParty.get(BASE_URL + path, headers: { "Api-Key" => @api_key})
    parsed_resp = Hashie::Mash.new().merge(JSON.parse(resp.body))
    if unwrap
      parsed_resp = parsed_resp.data
    else
      parsed_resp
    end

  end

end
