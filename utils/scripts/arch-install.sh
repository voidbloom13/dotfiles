#!/bin/bash

# Renames dotfiles folder to .dotfiles
if [[ -d "$HOME/dotfiles" ]]; then
  mv "$HOME/dotfiles" "$HOME/.dotfiles"
fi

# CDs to $HOME
cd

# Installs base packages
sudo pacman -Syu aspnet-runtime base-devel cifs-utils curl dotnet-runtime dotnet-sdk fastfetch fzf gcc git github-cli jdk-openjdk kitty man maven nvim nodejs npm obsidian ripgrep stow tree tmux unzip zoxide zsh

# Installs all nerd-fonts
sudo pacman -S $(pacman -Sgq nerd-fonts)

# Clones and Installs yay
git clone https://aur.archlinux.org/yay
cd yay
makepkg -si
cd .. && rm -rf yay

# Clones tmux/tpm
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# Downloads catppuccin theme for tmux
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux

# Installs VS Code
yay -S visual-studio-code-bin

# Installs Google Chrome
yay -S google-chrome

. $HOME/dotfiles/scripts/stow.sh
cd && clear && fastfetch && echo "Complete TMUX setup by running TMUX and pressing <C-b><i> to install TPM plugins. Please make sure to change user shell to zsh with chsh. Setup git config --global user.name and user.email. Authorize github using [gh auth login]."
