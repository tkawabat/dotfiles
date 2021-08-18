#

## 容量削減

```
rm -rf  /Users/tune/git/act_arena/android/.gradle/checksums
sudo rm -rf  ~/Library/Developer/Xcode/DerivedData
sudo rm -rf /Users/tune/Library/Developer/CoreSimulator/Caches/*

## 未確認だけどキャッシュだから
sudo rm -rf /System/Volumes/Data//Users/tune/Library/Developer/Xcode//iOS\ DeviceSupport/*/Symbols/System/Library/Caches/*
```

#### sleepimage
* https://qiita.com/pixel/items/020369601abe2b8c0188

#### 重いフォルダ
* /System/Volumes/Data//private
* /System/Volumes/Data//Users

## lightsail
* ssh

```
$ ssh -i <PEMファイル> -p <ポート> <USER>@<IP ADDRESS>
```

* scp

```
$ scp -i <pemファイル> -P <ポート> -r <FROM> <USER>@<TO>:
```
