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
