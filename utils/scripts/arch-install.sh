#!/bin/bash

# CDs to $HOME
cd

# Installs base packages
sudo pacman -Syu aspnet-runtime base-devel cifs-utils curl dotnet-runtime dotnet-sdk fastfetch fzf gcc ghostty git github-cli jdk-openjdk kitty man maven nvim nodejs npm obsidian ripgrep stow tmux tree unzip zoxide zsh

# Hyprland Options
read -p "Install hyprland ecosystem? [Y/n]: " ans
case $ans in
  [yY] ) sudo pacman -Syu hyprpaper hyprlock hypridle waybar swaync ttf-font-awesome;
    break;;
  [nN] ) break;;
  * ) break;;

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

# Installs NPM Packages
sudo npm install -g nodemon typescript typescript-language-server @tailwindcss/language-server

. $HOME/dotfiles/utils/scripts/stow.sh

cd && clear && fastfetch
