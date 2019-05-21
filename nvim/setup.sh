#!/usr/bin/env bash

set -x

mkdir -p ~/.config/nvim
cp --no-clobber init.vim ~/.config/nvim/
ln -f -s ${PWD}/init.basic.vim ~/.config/nvim/init.basic.vim
ln -f -s ${PWD}/init.plugins.vim ~/.config/nvim/init.plugins.vim
mkdir -p ~/.vim/bundle/
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim


