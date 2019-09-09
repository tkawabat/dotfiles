# ビルド

## アイコン
* サイズごとのアイコンをジェネレート
    * https://resizeappicon.com/
* ios
    * Xcode上で設定する
    * アプリのGeneralで「App Icon Source」の右矢印をクリック
    * 各サイズのアイコンを設定
* android
    * ファイルを置き換える
    
    ```
    $ for T in mdpi hdpi xhdpi xxhdpi xxxhdpi; do cp ~/Downloads/AppIconResizer_201909090521_3d40450b3e2c9235f06d8fbd7c9af672/${T}.png mipmap-${T}/ic_launcher.png; done
    ```

## アプリ名変更
* ios
    * Xcode上で変更する
    * アプリのGeneralで「Display Name」を変更する
* android
    * android/app/src/main/res/values/strings.xml のapp_nameを書き換える

## react-native-gesture-handlerで詰まった問題
* なんかiosのビルドでエラーになった
* 解決手順
    * PodFileからreact-native-gesture-handlerの記述を全部消す
    * pod update
    * react-native link
        * PodFileから消えていることを確認
    * Xcodeでclean build folder
    * もう一度ビルド
* 参考
    * https://qiita.com/b_a_a_d_o/items/a6318290cd8f7a339ae0

