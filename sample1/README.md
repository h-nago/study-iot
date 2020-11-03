# セットアップ
```
# 起動
docker-compose build
docker-compose up

# マッピング作成
# timestampにunixtimestampを利用しているため、esに任せるとlong型にされてしまう。なので事前に定義しておく。（long型で作成後はdate型に変更できないので注意）
docker-compose run --rm kibana curl http://es:9200/app/_mapping -d'{"properties": { "timestamp": { "type": "date", "format": "epoch_second" } } }' -XPUT -H 'Content-Type: application/json'

# トピック作成
docker-compose run --rm kafka bash -c -l "bin/kafka-topics.sh --create --topic app --partitions 1 --bootstrap-server kafka:9092"
```

# 概要
センサーデータを受け取る部分から先を想定したサンプル。以下のような流れ。
```
fluentd->kafka->fluentd->es
```
fluentdがhttpでデータを受け取り、kafkaに流す。
kafkaからfluentdでデータを受取esにデータを投入し、kibanaで可視化する。
kafkaを間に挟んだ構成にしているのは、kafka->kafka streaming(spark streaming)で準リアルタイムでの分析を考慮してみた。後はes以外のデータストアにもデータを入れて分析する場合とか。
次はセンサーをつなげてみようかな。
認証や可用性、スケールアップについても考えてみたいところ。
楽しい。