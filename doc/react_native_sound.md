# 音声系まとめ

## nativeへのaudioファイルの追加方法
* 方法1
    * 「File」-> 「Add file to Project」->音声ファイルを選択してAdd
    * 基本デフォルトでおっけー
* 方法2
    * 適当なディレクトリに設置後、xcodeの左にD&Dで追加

### android
* android/app/src/main/res/raw/ 以下に設置


## react native sound

* アプリ名にスペースや日本語が入っていると、iosでエラーが発生
    * ENSOSSTATUSERRORDOMAIN-10875
    * https://github.com/zmxv/react-native-sound/issues/630

## expo-av
* iosでskywayと共存したとき動作がおかしくなる
    * 音楽が聞こえない
    * 通話が落ちる
* expoにaudioファイルを置くので、ネイティブに追加しなくてよい

## react-native-sound-player
* 複数音声ファイルが流せない

## react-native-audio-toolkit
* 通話と組み合わせがうまく行かない
