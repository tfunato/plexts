require 'net/http'
require 'net/https'
require 'json'

module GetPrexts

    def self.get_prexts
        configure
        uri = URI('https://www.ingress.com/r/getPlexts')
        https = Net::HTTP.new(uri.host,uri.port)
        https.use_ssl = true
        req = Net::HTTP::Post.new(uri.path, headers )
        req.body = prexts_params
        res = https.request(req)
        # puts "Response #{res.code} #{res.message}: #{res.body}"
        json = JSON.parse(res.body)
        # puts JSON.pretty_generate(json)
    end
end
