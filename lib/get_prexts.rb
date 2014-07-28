require "get_prexts/version"
require 'net/http'
require 'net/https'
require 'json'

module GetPrexts
    def self.getPrexts
        uri = URI('https://www.ingress.com/r/getPlexts')
        https = Net::HTTP.new(uri.host,uri.port)
        https.use_ssl = true
        req = Net::HTTP::Post.new(uri.path, headers )
        req.body = params
        res = https.request(req)

        puts "Response #{res.code} #{res.message}: #{res.body}"

        #json = JSON.parse(res)
    end

    def self.headers
        initheaders = {
            'content-Type' => 'application/json; charset=UTF-8',
            'user-agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36',
            'x-csrftoken' => 'xtzBPR7tlTzqlHQqhPZf0iiwlhpM6m1J',
            'referer' => 'https://www.ingress.com/intel',
            'cookie' => cookies
        }
    end

    def self.cookies
        cookie = {
            'GOOGAPPUID' => '262',
            'csrftoken' => 'xtzBPR7tlTzqlHQqhPZf0iiwlhpM6m1J',
            'ingress.intelmap.shflt' => 'viz',
            'ingress.intelmap.lat' => '35.574955',
            'ingress.intelmap.lng' => '139.623564',
            'ingress.intelmap.zoom' => '16',
            'SACSID' => 'AJKiYcGMK-lE3C6uLmPJNEG634p0ZETjgp40hRpuaY0MGNOEdqy-bCfJOUh5y9u2PMrNuNMey4I4NqFXWIDSuyFKwD0tRcqcRqwA_dPMj2xhel37Y1iH_KC4J6hIsZghQ1VNUK4qn3Z7H1WYFtI3mTzCLEFCWv7BToxa9sMWuvUjtya1ZMSp5Edz8Gg10-Jwy6XntiSXhkVMNDv-obH8IxEaZ4bDkPNBeM0hQJiiKRnTRPm2Q5unsm8ryBOV73PuFx_PFplVTwe4HMquM5Isoq8FHZ4I2RTebm4S-yYu6ik_KqZgJ0VW7Hv3rZw-PMqVggdFg3ELInztGvyU4uIDM8dnR_sc5ppatRfjuJtLVPV1ouSI8eQT0Lhyv37UQPGIXedWAwkqMdKejs_hHuL0aJoCsp2ngu1Y6obe6JRA74hR9n-74XjhTuSvbWpDgY0DKwgQlgvEWBCzIjRIUBbLlG4tYbntMldGs8hj73yLyH8TSpcNGzpitxZ7xdNlwq3604P18g0i4onw0S7xRwCBfWdPqs4jxzdkRoUtEDnlimZYGG1qHmWu0rGRbtrSdf91ITiu6CtLk5ahRL1oPQEYg3VC7XajZR1N60VoZW-wkoBppHNx17eMOyA'
        }
        cookie.map{|k,v|
            "#{k}=#{v}"
        }.join('; ')
    end

    def self.params
        toSend = {
            "minLatE6" => 35569894,
            "minLngE6" => 139610872,
            "maxLatE6" => 35580016,
            "maxLngE6" => 139636256,
            "minTimestampMs" => -1,
            "maxTimestampMs" => -1,
            "tab" => "all",
            "v" => "39bcf52fb8e9da4f4161219bc0e650642ac20f9d"
        }.to_json
    end
end
