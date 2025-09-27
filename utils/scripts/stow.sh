#!/bin/bash

DOTFILES_DIR="$HOME/.dotfiles"

# Add any dotfiles you want to track here. Include the path from $HOME.
DOTFILES=(".bash_aliases", ".bashrc", ".profile", ".tmux.conf", ".zshrc", ".config/nvim", ".config/nvchad")

for dotfile in "${DOTFILES[@]}"; do
	rm -rf "$HOME/$dotfile"
done

stow -v -d "$DOTFILES_DIR" -t "$HOME" .
