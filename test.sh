#!/bin/bash
cd

rm -rf .bashrc .bash_aliases .profile .config/nvchad

source ~/.dotfiles/utils/scripts/stow.sh
