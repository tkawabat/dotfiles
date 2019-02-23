#!/bin/bash

for F in .??*
do
    if [ "$F" = ".git" ]; then continue; fi
    if [ "$F" = ".gitignore" ]; then continue; fi
    if [ "$F" = ".DS_Store" ]; then continue; fi

    if [ ! -e ~/$F ]; then 
        echo "create $F"
        ln -s `pwd`/$F ~/$F
    fi
done

if [ ! -e ~/local ]; then mkdir ~/local; fi
if [ ! -e ~/pkg ]; then mkdir ~/pkg; fi
if [ ! -e ~/.vim/bundle ]; then mkdir -p ~/.vim/bundle && git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim; fi
