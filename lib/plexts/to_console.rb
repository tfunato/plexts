
module Plexts

    def self.to_console()

        json = get_plexts
        json["success"].reverse!.each do |plext| 
            s = plext[1].to_s
            s = s[0, s.length - 3] 

            print Time.at(s.to_i).strftime("%Y-%m-%d %R | ")
            text = ""
            plext[2]["plext"]["markup"].each do |markups|
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
                    text << " https://www.ingress.com/intel?ll=" + lat.to_s + "," + lag.to_s + "&z=19&pll=" + lat.to_s + "," + lag.to_s
                elsif markups[0] == "TEXT" 
                    if plext[2]["plext"]["categories"] == 4
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
