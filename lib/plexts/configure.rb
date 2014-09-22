require 'pit'

module Plexts
    def self.configure
        @config = Pit.get("ingress")
        if @config["csrftoken"] == nil
            raise "need pit settings."
        end
    end

    def self.headers
        cookie = {
            'GOOGAPPUID' => '499',
            'csrftoken' => @config["csrftoken"],
            'SACSID' => @config['SACSID']
        }
        initheaders = {
            'content-Type' => 'application/json; charset=UTF-8',
            'user-agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36',
            'x-csrftoken' => @config['csrftoken'],
            'referer' => 'https://www.ingress.com/intel',
            'cookie' => cookie.map{|k,v|
                            "#{k}=#{v}"
                        }.join('; ')
        }
    end

    def self.plexts_params
        toSend = {
            "minLatE6" => @config["minLatE6"],
            "minLngE6" => @config["minLngE6"],
            "maxLatE6" => @config["maxLatE6"],
            "maxLngE6" => @config["maxLngE6"],
            "minTimestampMs" => @config["minTimestampMs"],
            "tab" => @config["tab"],
            "v" => @config["v"]
        }.to_json
    end

    def self.artifacts_params
        toSend = {
            "v" => @config["v"]
        }.to_json
    end
    def self.entities_params(lat, lng, zoom=20)
        toSend = {
            "tileKeys" => [get_mercator_tile(lat, lng, zoom)],
            "v" => @config["v"]
        }.to_json
    end
end
