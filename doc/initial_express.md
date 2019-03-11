## node express

* install

```
$ sudo npm install -g npm
$ sudo npm install -g express
$ sudo npm install -g express-generator
```

* generator

```
$ express --ejs --git random_matching
### jadeがdeprecatedらしいので適当にejs
$ cd random_matching
$ npm install
### cacheファイルの権限がない的なのが出たので、キャッシュを消して再実行
$ npm start
```

* light sailの設定で3000番ポートを開けて、ブラウザで確認


## nodemon

```
$ sudo npm i nodemon --save-dev
$ sudo ./node_modules/.bin/nodemon bin/www
```

## deamon

* install 

```
$ sudo npm i pm2 -g
```

* use

```
$ sudo pm2 start bin/www --name myapp
$ sudo pm2 start bin/www --name myapp -i 0
# -i 0でコア数分クライアントを立ち上げる
```

* use config file

```
$ cat pm2.yml
name: myapp                            # アプリ名
script: app.js                         # スクリプトファイルパス
exec_mode: "cluster"                   # 起動モード = cluster
instances: 0                           # 起動インスタンス数
log-date-format: "YYYY-MM-DD HH:mm Z"  # ログに日付を追加
```
