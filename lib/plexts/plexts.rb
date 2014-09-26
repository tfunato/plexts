require 'net/http'
require 'net/https'
require 'json'
require "pry"

module Plexts

    def self.get_plexts
        configure
        uri = URI('https://www.ingress.com/r/getPlexts')
        https = Net::HTTP.new(uri.host,uri.port)
        https.use_ssl = true
        req = Net::HTTP::Post.new(uri.path, headers )
        req.body = plexts_params
        res = https.request(req)
        if !res.kind_of? Net::HTTPSuccess
            raise res.code + ":" + res.msg
        end
        # puts "Response #{res.code} #{res.message}: #{res.body}"
        json = JSON.parse(res.body)
        # puts JSON.pretty_generate(json)
    end
end
