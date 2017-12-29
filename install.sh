#!/bin/bash

for F in .??*
do
    [[ "$F" == ".git" ]] && continue
    [[ "$F" == ".gitignore" ]] && continue
    [[ "$F" == ".DS_Store" ]] && continue

    echo "$F"
    ln -s `pwd`/$F ~/$F
    exit
done
