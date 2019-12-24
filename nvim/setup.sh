#!/usr/bin/env bash

set -x

mkdir -p ~/.config/nvim
cp --no-clobber init.vim ~/.config/nvim/
ln -f -s ${PWD}/init.basic.vim ~/.config/nvim/init.basic.vim
ln -f -s ${PWD}/init.plugins.vim ~/.config/nvim/init.plugins.vim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim +PlugInstall +qall
