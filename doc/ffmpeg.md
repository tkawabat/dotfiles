## ffmpeg

### 結婚式動画のダウンロード
* HTMLを見たらm3u8形式だった。
* ffmpegコマンドでmp4に変換して保存

```
/Applications/ffmpeg -i "<m3u8 URL>" -c copy output2.mp4
```

    * ダブルコーテーションなしだとエラーになった。

* サイズがでかいので圧縮
* 試すためにカットして1分の動画を作成

```
ffmpeg -ss 600 -to 660 -i input.mp4 -c copy output.mp4
```

* 圧縮
    * crfの数値が大きいほど圧縮
        * crf=18だと元動画より大きくなった
        * crf=31だと1/8になった

```
ffmpeg -i input.mp4 -crf 31 output.mp4
```
