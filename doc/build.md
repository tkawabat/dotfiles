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

