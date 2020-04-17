#

## 容量削減

```
rm -rf  /Users/tune/git/act_arena/android/.gradle/checksums
sudo rm -rf  ~/Library/Developer/Xcode/DerivedData
sudo rm -f /private/var/vm/sleepimage
```

## lightsail
* ssh

```
$ ssh -i <PEMファイル> -p <ポート> <USER>@<IP ADDRESS>
```

* scp

```
$ scp -i <pemファイル> -P <ポート> -r <FROM> <USER>@<TO>:
```
