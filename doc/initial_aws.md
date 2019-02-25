# AWS使い始めたときにやったこと

## サーバ
* パスワード変更

```
$ sudo passwd ec2-user
$ sudo passwd root
```

* SSH設定
    * 以下の変更はセッションを一つ繋いで、戻せるようにしながらやる
    * AWSのコンソールからセキュリティグループを編集
        * プロトコルをSSHからカスタムプロトコルに
        * ポートを適当に変更

    ```
    $ sudo cp /etc/ssh/sshd_config{,.old}
    $ sudo vim /etc/ssh/sshd_config
    
    (略)
    
    #Port 22
    Port XXX  <= 実際のポート番号を設定する
    #AddressFamily any
    #ListenAddress 0.0.0.0
    #ListenAddress ::

    $ sshd -t
    # エラーが出ないことを確認
    $ sudo service sshd restart
    ```

    * puttyで新たなセッションを開いて動作確認

* 時間設定

```
$ sudo cp /etc/localtime /etc/localtime.bak
$ sudo cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
```


## Git
* install

```
$ sudo yum install git
```

* SSH key
    * puttyのやつを登録

* config

```
$ git config --global user.name "tkawabat"
$ git config --global user.email tosiki.kawabata@gmail.com
$ git config --global alias.st status
$ git config --global alias.co commit
```

* 補完

    * スクリプトファイル取得

    ```
    $ wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
    $ mv {,.}git-completion.zsh
    ```

    * .zshrcに追加

    ```
    zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
    ```

## vim
* .vimrcかきかき

## tmux

## zsh
* install

```
$ yum install zsh
$ cat /etc/shell
$ chsh -s zsh
```

## node

```
$ sudo yum install gcc-c++
$ 
```
