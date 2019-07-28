## 準備1

```
# リポジトリ作成
$ expo init skyway-sample
## typescript blunkを選ぶ
## コミットしておいてもいいかも

# ネイティブコードを使うためにejectする
$ cd skyway-sample
$ npm run eject
## Expokitを選ぶ

# react-native-skyway追加
$ npm install "git+ssh://git@github.com/micin-jp/react-native-skyway.git#v0.1.1" --save
$ react-native link
```

## ios
* podファイルを作ってpod install
    * https://qiita.com/daisaru11/items/52c10514ba2fa2dd1b87
* RNSkyWayの[Build Phase]でHeadersのprojectにskywayの.hファイルを追加

## android

```
$ mkdir android/app/libs
```

* android skdのaarを配置
    * https://webrtc.ecl.ntt.com/android-sdk.html#sdkdownload
* android studioから[File] > [New] > [New Module]で読み込む
* android/app/src/main/AndroidManifest.xmlに以下追加
    * これ本当にいるか不明

```
    <activity
      android:name=".MainActivity"
      android:launchMode="singleTask"
      android:configChanges="keyboard|keyboardHidden|orientation|screenSize"
      android:theme="@style/Theme.Exponent.Splash"
      android:windowSoftInputMode="adjustResize"
+     android:exported="true"
      >
```

    * 追加済みなら一度gradleをcleanする

* cd android && ./gradlew app:installDebug

## room機能追加
* react-native-skywayは1:1通信しか実装されていないので追加する
* コード修正してアプリをビルドしなおせばおっけー

### 変更する箇所
* node_modules/react-native-skyway以下
* 共通
    * src/Peer.js
    * index.d.ts
        * これの役割がよくわからない
* ios
    * ios/RNSkyWayPeer.h
    * ios/RNSkyWayPeer.m
    * ios/RNSkyWayPeerManager.m
* android
    * android/src/main/java/jp/micin/react/skyway/SkyWay/SkyWayPeer.java
    * android/src/main/java/jp/micin/react/skyway/SkyWay/SkyWayPeerManagerModule.java
