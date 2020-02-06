# npm
* react-native-firebase と firebase という別パッケージがnpmにある
* 後者の方
    * 前者のほうが高機能で良さそう・・・。

## iosでfirebaseにアプリを追加
* 以下でGoogleService-Info.plistをコピーするようにする
    * https://qiita.com/KazaKago/items/aacf6eaec65b6d4244d0
* SDKを追加
    * AppDelegate.m に数行追加
* 修正コミット
    * https://github.com/tkawabat/act_arena/commit/94b1c39fac204db75cf3378e446b1e4523b1554c
