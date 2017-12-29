#!/bin/bash

for F in .??*
do
    [[ "$F" == ".git" ]] && continue
    [[ "$F" == ".gitignore" ]] && continue
    [[ "$F" == ".DS_Store" ]] && continue

    [[ -e ~/$F ]] && continue
    echo "create $F"
    ln -s `pwd`/$F ~/$F
done

[[ ! -e ~/local ]] && mkdir ~/local
[[ ! -e ~/pkg ]] && mkdir ~/pkg
