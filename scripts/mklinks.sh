#!/bin/bash

# Checks if dotfiles_old directory exists. Creates it if it doesn't
if [[ ! -d $HOME/dotfiles_old ]]; then
	mkdir -p $HOME/dotfiles_old
fi

# Checks old dotfiles and moves them to the dotfiles_old directory
if [[ -f .bashrc ]]; then
	mv .bashrc $HOME/dotfiles_old/.bashrc
fi
if [[ -f .bash_aliases ]]; then
	mv .bash_aliases $HOME/dotfiles_old/.bash_aliases
fi
if [[ -d .config/nvim ]]; then
	mv .config/nvim $HOME/dotfiles_old/nvim
fi
if [[ -f .tmux.conf ]]; then
	mv .tmux.conf $HOME/dotfiles_old/.tmux.conf
fi

# Creates the .config directory if it doesn't already exits.
if [[ ! -d $HOME/.config ]]; then
  mkdir .config
fi

# Creates symlinks from dotfiles folder to original location
ln -s $HOME/dotfiles/.bashrc $HOME/.bashrc
ln -s $HOME/dotfiles/.bash_aliases $HOME/.bash_aliases
ln -s $HOME/dotfiles/nvim $HOME/.config
ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
