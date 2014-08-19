require 'net/http'
require 'net/https'
require 'json'

module Plexts

    def self.get_artifacts
        configure
        uri = URI('https://www.ingress.com/r/artifacts')
        https = Net::HTTP.new(uri.host,uri.port)
        https.use_ssl = true
        req = Net::HTTP::Post.new(uri.path, headers )
        req.body = artifacts_params
        res = https.request(req)
        if !res.kind_of? Net::HTTPSuccess
            raise res.code + ":" + res.msg
        end
        # puts "Response #{res.code} #{res.message}: #{res.body}"
        json = JSON.parse(res.body)
        puts JSON.pretty_generate(json)
    end
end
