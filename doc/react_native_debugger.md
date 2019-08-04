# debugger

## 実機
* 参考
    * https://qiita.com/Tetsuya3850/items/e8d4450fcb3df5522b7a
* ファイルの編集

```
$ vim node_modules/react-native/Libraries/Core/Devtools/setupDevtools.js


    //const host = devServer.bundleLoadedFromServer
    //  ? devServer.url.replace(/https?:\/\//, '').split(':')[0]
    //  : 'localhost';
    const host = 'xxx.xxx.xxx.xxx';
```

* 実機を振ってデバッグする
