#!/usr/bin/env bash

mkdir -p ~/.config/nvim
cp --no-clobber init.vim ~/.config/nvim/
ln -s ${PWD}/init.basic.vim ~/.config/nvim/init.basic.vim
ln -s ${PWD}/init.plugins.vim ~/.config/nvim/init.plugins.vim

