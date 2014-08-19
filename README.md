# Plexts

## 説明
ruby gem形式で書いてあります。

gemを使ったアプリを書くのが面倒なので、rspecで実行するようになってますｗ

解凍したディレクトリで

    $ rspec

でspec/plexts_spec.rbがキックされて実行します。

## 設定

Pitを使ってます

https://github.com/cho45/pit

Pitの設定項目


    ingress:
      # Requestパラメータ、ChromeなどのDeveloperToolsなどでリクエストを覗いてください。。。
      maxLatE6: 
      maxLngE6: 
      minLatE6: 
      minLngE6: 
      maxTimestampMs: -1
      minTimestampMs: -1
      tab: "all" # タブの種類 all, faction, alerts
      v: "85c5f3500d547f7c4f7165df96d739dcfa496987" # Intelマップのバージョン
      # Cookieデータ
      csrftoken: # CSRFのトークン
      SACSID:  # 認証情報（取り扱い注意!）

