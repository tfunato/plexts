require 'dotenv'

module Plexts
    def self.configure
      Dotenv.load
    end

    def self.headers
        cookie = {
            'GOOGAPPUID' => ENV["GOOG_APP_UID"],
            'csrftoken' => ENV["CSRF_TOKEN"],
            'SACSID' => ENV['SACS_ID']
        }
        initheaders = {
            'content-Type' => 'application/json; charset=UTF-8',
            'user-agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36',
            'x-csrftoken' => ENV['CSRF_TOKEN'],
            'referer' => 'https://www.ingress.com/intel',
            'cookie' => cookie.map{|k,v|
                            "#{k}=#{v}"
                        }.join('; ')
        }
    end

    def self.plexts_params
        toSend = {
            "minLatE6" => ENV["MIN_LAT_E6"],
            "minLngE6" => ENV["MIN_LNG_E6"],
            "maxLatE6" => ENV["MAX_LAT_E6"],
            "maxLngE6" => ENV["MAX_LNG_E6"],
            "minTimestampMs" => ENV["MIN_TIMESTAMP_MS"],
            "tab" => ENV["TAB"],
            "v" => ENV["VERSION"]
        }.to_json
    end

    def self.artifacts_params
        toSend = {
            "v" => ENV["VERSION"]
        }.to_json
    end
    def self.entities_params(lat, lng, zoom=20)
        toSend = {
            "tileKeys" => [get_mercator_tile(lat, lng, zoom)],
            "v" => ENV["VERSION"]
        }.to_json
    end
end
