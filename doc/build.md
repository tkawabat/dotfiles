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

## jetify
* react-native-permissionsで利用
* 雑理解
    * androidxのパッケージを、古いバージョンに戻してくれるもの

```
$ npx jetifier -r
$ npx react-native run-android
```

## iOS対応
* https://github.com/filsv/iPhoneOSDeviceSupport

```
$ mv ~/Downloads/13.0 /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport/
```

## Androidリリースビルド

```
$ expo publish
```

* keystore作成

```
$ cd android/app
$ keytool -genkey -v -keystore act_arena.keystore -alias act_arena -keyalg RSA -keysize 2048 -validity 10000
キーストアのパスワードを入力してください:
新規パスワードを再入力してください:
姓名は何ですか。
  [Unknown]:  Toshiki Kawabata
組織単位名は何ですか。
  [Unknown]:
組織名は何ですか。
  [Unknown]:
都市名または地域名は何ですか。
  [Unknown]:
都道府県名または州名は何ですか。
  [Unknown]:
この単位に該当する2文字の国コードは何ですか。
  [Unknown]:  JP
CN=Toshiki Kawabata, OU=Unknown, O=Unknown, L=Unknown, ST=Unknown, C=JPでよろしいですか。
  [いいえ]:
姓名は何ですか。
  [Toshiki Kawabata]:
組織単位名は何ですか。
  [Unknown]:
組織名は何ですか。
  [Unknown]:
都市名または地域名は何ですか。
  [Unknown]:
都道府県名または州名は何ですか。
  [Unknown]:
この単位に該当する2文字の国コードは何ですか。
  [JP]:
CN=Toshiki Kawabata, OU=Unknown, O=Unknown, L=Unknown, ST=Unknown, C=JPでよろしいですか。
  [いいえ]:  Y

10,000日間有効な2,048ビットのRSAのキー・ペアと自己署名型証明書(SHA256withRSA)を生成しています
        ディレクトリ名: CN=Toshiki Kawabata, OU=Unknown, O=Unknown, L=Unknown, ST=Unknown, C=JP
[your_app_name.keystoreを格納中]
```

* ビルド

```
$ cd android
$ ./gradlew assembleRelease
```

* インストール

```
$ react-native run-android --variant=release
```

## 解決した問題
### Android
* keystoreのパスワード２つあるけど何書けばいい？
    * 両方同じ
* shell-app-manifest.jsonがないエラー
    * expo publishを一回やる
* JNI_ERR returned from JNI_OnLoad in libskyway.so
    * app/proguard-rules.proに以下の一行追加
    * -keep class io.skyway.Peer.** {*;}
* signが必要？
    * 勝手にやられるから必要ないっぽい
    
    ```
    $ jarsigner -verify -verbose android/app/build/outputs/apk/release/app-release.apk
    ```

* zipalignが必要？
    * 勝手にやられるから必要ないっぽい
    
    ```
    $ ~/Library/Android/sdk/build-tools/29.0.0/zipalign -c -v 4 android/app/build/outputs/apk/debug/app-debug.apk

    (略)

    Verification succesful
    ```

### iOS(Xcode 10.1)
#### Apple Mach-O Linker
* RNSkywayがないエラー
* 一回目
    * https://webrtc.ecl.ntt.com/ios-tutorial.html
    * SDKの追加をやり直したら治った
* 再発
    * Linked Framework and LibrariesからlibRNSkywayを消したらビルドできた
        * でも実行時にNative Module cannnot null のエラーが出た
    * 色々いじっていて、libRNSkywayを足したあと治った
        * 詳細がよくわからん・・・

#### stagingの作り方
* terminal
    1. cp ios/act_arena/Supporting/EXShell.plist{,.stg}
    1. vim ios/act_arena/Supporting/EXShell.plist.stg
        * release_channelをstgに
* xcode上で
    * TARGETSをコピー
    * スキーマ名を変更
    * スキーマのbuild configurationをreleaseに
    * [Build phase] -> [Copy Bundle Resource]で上記ファイルを置き換え

#### react-native-background-fetch
* pathが間違っている
    * [Build Phase] -> [Compline Source]
    * ヘッダーを一度消してから、node_modules以下のを追加
* https://github.com/transistorsoft/react-native-background-fetch/issues/173

#### AppDelegate.h not found
* Podファイルをもとに戻す
* 以下のコマンドで消してやり直す

```
rm -rf Pods Podfile.lock build && pod install
```

### iOS(Xcode 11)
#### GoogleService-Info.plist
* プロジェクトルートにおいてある、GoogleService-Info-***.plist をコピーするスクリプトをbuild phasesで仕込む
    * PROJECTファイル -> TARGETS -> Build Phases -> + -> New Run Script Phase
* https://qiita.com/KazaKago/items/aacf6eaec65b6d4244d0

#### TCCVPixelBuffer is implemented
* ログは出るけど、これは無視してOK
* アプリ落ちるなら別の要因

#### 音声ファイルの読み込みができなくなった
* react-native-sound でアプリ名にスペースや日本語が入っているとエラーになる

