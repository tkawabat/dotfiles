#!/bin/bash

function make_link() {
    if [ -e $1 ]; then
        echo "$1 already exists. skip create."
    else
        echo "create $1 link."
        ln -s $2 $1
    fi
}

for F in .??*
do
    if [ "$F" = ".git" ]; then continue; fi
    if [ "$F" = ".gitignore" ]; then continue; fi
    if [ "$F" = ".DS_Store" ]; then continue; fi

    make_link ~/$F `pwd`/$F
done

make_link ~/.ssh/config `pwd`/.ssh/config

if [ ! -e ~/local ]; then mkdir ~/local; fi
if [ ! -e ~/pkg ]; then mkdir ~/pkg; fi
if [ ! -e ~/.vim/bundle ]; then mkdir -p ~/.vim/bundle && git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim; fi
