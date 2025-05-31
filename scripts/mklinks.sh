#!/bin/bash

# Checks if .bash_aliases exists, and copies contents to new .bash_aliases file.
if [ -f $HOME/.bash_aliases ]; then
    mv $HOME/dotfiles/.bash_aliases $HOME/dotfiles/.bash_aliases.tmp
    cat $HOME/.bash_aliases $HOME/dotfiles/.bash_aliases.tmp | sort | uniq | grep -v '^$' > $HOME/dotfiles/.bash_aliases
    rm $HOME/dotfiles/.bash_aliases.tmp
fi

# Checks if dotfiles_old directory exists. Creates it if it doesn't
if [[ ! -d $HOME/dotfiles_old ]]; then
	mkdir -p $HOME/dotfiles_old
fi

# Checks old dotfiles and moves them to the dotfiles_old directory
if [[ -f $HOME/.zshrc ]]; then
  mv $HOME/.zshrc $HOME/dotfiles_old/.zshrc
fi
if [[ -f $HOME/.bashrc ]]; then
	mv $HOME/.bashrc $HOME/dotfiles_old/.bashrc
fi
if [[ -f $HOME/.bash_aliases ]]; then
	mv $HOME/.bash_aliases $HOME/dotfiles_old/.bash_aliases
fi
if [[ -d $HOME.config/nvim ]]; then
	mv $HOME/.config/nvim $HOME/dotfiles_old/nvim
fi
if [[ -f $HOME.tmux.conf ]]; then
	mv $HOME/.tmux.conf $HOME/dotfiles_old/.tmux.conf
fi

# Creates the .config directory if it doesn't already exits.
if [[ ! -d $HOME/.config ]]; then
  mkdir -p $HOME/.config
fi

# Creates symlinks from dotfiles folder to original location
ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/.bashrc $HOME/.bashrc
ln -s $HOME/dotfiles/.bash_aliases $HOME/.bash_aliases
ln -s $HOME/dotfiles/nvim $HOME/.config
ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
