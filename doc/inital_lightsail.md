# AWS LightSailを使い始めたときにやったこと

* node環境を利用
* git, tmux, nodeははじめから入っている

## サーバ
* パスワード変更

```
$ sudo passwd root
$ sudo passwd bitnami
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

## zsh

```
$ sudo apt install zsh
# なんかエラーになる。lockファイルが云々

$ sudo rm /var/lib/apt/lists/lock /var/cache/apt/archives/lock
$ sudo apt install zsh
$ zsh
$ chsh -s /usr/bin/zsh

```


## Git
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

    * dotfiles
    
    ```
    $ cd ~/git/
    $ git clone git@github.com:tkawabat/dotfiles.git
    $ cd dotfiles
    $ sh install.sh
    # エラー出まくったけどファイル存在確認なので気にしない
    ```
