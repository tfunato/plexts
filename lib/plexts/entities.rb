require 'net/http'
require 'net/https'
require 'json'

module Plexts

    ZOOM_TO_NUM_TILES_PER_EDGE = [64, 64, 64, 64, 256, 256, 256, 1024, 1024, 1536, 4096, 4096, 6500, 6500, 6500]

    def self.get_entities(lat, lng, zoom=20)
        if !(lat.between?(-90, 90) && lng.between?(-180, 180))
            raise StandardError, "irregular parameter"
        end
        configure
        uri = URI('https://www.ingress.com/r/getEntities')
        https = Net::HTTP.new(uri.host,uri.port)
        https.use_ssl = true
        req = Net::HTTP::Post.new(uri.path, headers )
        req.body = entities_params(lat, lng, zoom)
        res = https.request(req)
        if !res.kind_of? Net::HTTPSuccess
            raise res.code + ":" + res.msg
        end
        # puts "Response #{res.code} #{res.message}: #{res.body}"
        json = JSON.parse(res.body)
        puts JSON.pretty_generate(json)
    end

    # parameter sample
    # 17_7994_3544_0_8_100
    # 17: zoom level
    # 7994: mercator tile lan param
    # 3544: mercator tile lng param
    # 0: min portal level(0-8)
    # 8: max portal level(0-8)
    # 100: max portal health (25, 50, 75, 100)
    def self.get_mercator_tile(lat, lng ,zoom=17, pMinLevel=0, pMaxLevel=8, maxHealth=100)
        z = ZOOM_TO_NUM_TILES_PER_EDGE[zoom] || 9000
        lg = ((lng + 180) / 360 * z).to_i
        lt =  ((1 - Math.log(Math.tan(lat * Math::PI / 180) + 1 / Math.cos(lat * Math::PI / 180)) / Math::PI) / 2 * z).to_i
        tileKey = [zoom, lg, lt, pMinLevel, pMaxLevel, maxHealth].join('_')
        # puts tileKey
    end
end
