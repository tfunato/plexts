require 'net/http'
require 'net/https'
require 'json'
require 'pit'

module GetPrexts

    def self.get_prexts
        @config = Pit.get("ingress")
        if @config["csrftoken"] == nil
            raise "need pit settings."
        end

        uri = URI('https://www.ingress.com/r/getPlexts')
        https = Net::HTTP.new(uri.host,uri.port)
        https.use_ssl = true
        req = Net::HTTP::Post.new(uri.path, headers )
        req.body = params
        res = https.request(req)
        # puts "Response #{res.code} #{res.message}: #{res.body}"

        json = JSON.parse(res.body)
        # puts JSON.pretty_generate(json)
    end

    private
    def self.headers
        cookie = {
            'GOOGAPPUID' => '262',
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

    def self.params
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
end
