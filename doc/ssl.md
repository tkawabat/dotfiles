# SSL化
* 参考
    * https://qiita.com/k-yamada-github/items/7314003de7bdcbb2d39b

* メモ

```
$ sudo apt-get install letsencrypt

# 80番ポート使っているプロセスを見つけて止める
$ ss -antu
$ sudo apachectl stop

$ sudo letsencrypt certonly --standalone -d hoge.example.com
```
