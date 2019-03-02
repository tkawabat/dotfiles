# viライク
bindkey -e

# 自動保管
autoload -U compinit; compinit

# プロンプト
PROMPT='%~$ '

# cdしたらディレクトリスタックに追加
setopt auto_pushd

# pushd したとき、ディレクトリがすでにスタックに含まれていればスタックに追加しない
setopt pushd_ignore_dups

# 拡張 glob を有効にする
setopt extended_glob

# history
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000 # メモリサイズ
export SAVEHIST=100000 # ファイルサイズ
setopt hist_ignore_all_dups # 重複削除

# コマンドがスペースで始まる場合、コマンド履歴に追加しない
setopt hist_ignore_space

# <Tab> でパス名の補完候補を表示したあと、
# 続けて <Tab> を押すと候補からパス名を選択できるようになる
# 候補を選ぶには <Tab> か Ctrl-N,B,F,P
zstyle ':completion:*:default' menu select=1

# 単語の一部として扱われる文字のセットを指定する
# ここではデフォルトのセットから / を抜いたものとする
# こうすると、 Ctrl-W でカーソル前の1単語を削除したとき、 / までで削除が止まる
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

alias ll="ls -al"
alias rm="rm -i"
alias svim="sudo vim"


# git補完
zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh

export PATH=${HOME}/local/bin/:${PATH}

# tmux用にlibeventのパスを教える
export LD_LIBRARY_PATH=${HOME}/local/lib:$LD_LIBRARY_PATH

if [ -e ~/.local_zsh_rc ]; then source ~/.local_zsh_rc; fi
