require 'net/http'
require 'net/https'
require 'json'
require 'pit'
require 'pstore'

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

    def self.attack_notification

        @config = Pit.get("ingress")

        if @config["csrftoken"] == nil
            raise "need pit settings."
        end
        @config['tab'] = 'alerts'
        json = get_prexts
        #puts JSON.pretty_generate(json)
        db = PStore.new('/tmp/ingress_check')
        db.transaction do
            if !db['alerts_ids'] 
                db['alerts_ids'] = Array.new()
            end
            ids = db['alerts_ids'] 
            json["success"].each do |prext| 
                id = prext[0]
                if !ids.include?(id)
                    msg = prext[2]['plext']["text"]
                    cmd = "growlnotify -t 'ingress' -m '" + msg + "'"
                    system(cmd)
                    ids.push(id) 
                end
            end
        end
    end

    def self.to_console()

        json = get_prexts

        json["success"].reverse!.each do |prext| 
            s = prext[1].to_s
            s = s[0, s.length - 3] 

            print Time.at(s.to_i).strftime("%Y-%m-%d %R | ")

            text = ""

            prext[2]["plext"]["markup"].each do |markups|
                if markups[0] == "PLAYER"
                    if markups[1]["team"] == "RESISTANCE"
                        text << TermColor.blue
                    elsif markups[1]["team"] == "ENLIGHTENED"
                        text << TermColor.green
                    end
                    text << markups[1]["plain"]
                    text << TermColor.reset
                elsif markups[0] == "PORTAL" 
                    if markups[1]["team"] == "RESISTANCE"
                        text << TermColor.blue
                    else
                        text << TermColor.green
                    end
                    text << markups[1]["name"]
                    text << TermColor.reset
                    lat = markups[1]["latE6"]  / 1e6
                    lag = markups[1]["lngE6"]  / 1e6
                    text << " https://www.ingress.com/intel?ll=" + lat.to_s + "," + lag.to_s + "&z=13&pll=" + lat.to_s + "," + lag.to_s
                elsif markups[0] == "TEXT" 
                    if prext[2]["plext"]["categories"] == 4
                        text << TermColor.red
                        text << markups[1]["plain"]
                        text << TermColor.reset
                    else
                        text << markups[1]["plain"]
                    end
                elsif markups[0] == "SECURE" 
                    text << markups[1]["plain"]
                elsif markups[0] == "SENDER" 
                    text << TermColor.blue
                    text << markups[1]["plain"]
                    text << TermColor.reset
                end
            end
            puts text
        end
    end

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
    class TermColor
      class << self
        # 色を解除
        def reset   ; c 0 ; end 

        # 各色
        def red     ; c 31; end 
        def green   ; c 32; end 
        def yellow  ; c 33; end 
        def blue    ; c 34; end 
        def magenta ; c 35; end 
        def cyan    ; c 36; end 
        def white   ; c 37; end

        # カラーシーケンスを出力する
        def c(num)
          "\e[#{num.to_s}m"
        end 
      end 
    end
end
