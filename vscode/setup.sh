#! /usr/bin/env bash
mkdir -p ${HOME}/.config/Code/User
ln -f -s ${PWD}/settings.json ${HOME}/.config/Code/User/settings.json
ln -f -s ${PWD}/keybindings.json ${HOME}/.config/Code/User/keybindings.json
