# SSL化
* 参考
    * https://qiita.com/k-yamada-github/items/7314003de7bdcbb2d39b

* メモ

```
$ sudo apt-get install letsencrypt

# 80番ポート使っているプロセスを見つけて止める
$ ss -antu
$ sudo apachectl stop

# lightsailだと勝手に起動するのでいかがいいかも？
$ sudo /opt/bitnami/ctlscript.sh stop


$ sudo letsencrypt certonly --standalone -d hoge.example.com
```

* きまぐれ用コマンド

```
# いらないかも？
$ sudo apachectl stop

$ cd <リポジトリroot>
$ sudo pm2 stop pm2.json --only prod && sudo letsencrypt certonly --standalone -d random-matching.tokyo && sudo pm2 start pm2.json --only prod
```
