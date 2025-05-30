#!/bin/bash

# CDs to $HOME
cd

# Installs base packages
sudo pacman -Syu base-devel chromium cifs-utils curl gcc git github-cli jdk-openjdk kitty maven nvim nodejs npm obsidian tree tmux unzip zsh

# Installs all nerd-fonts
sudo pacman -S $(pacman -Sgq nerd-fonts)

# Clones and Installs yay
git clone https://aur.archlinux.org/yay
cd yay
makepkg -si
cd && rm -rf yay

# Clones tmux/tpm
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# Installs VS Code
yay -S visual-studio-code-bin

# Installs Google Chrome
yay -S google-chrome

read -p "Setup Git config? [Y]es [N]o : " gh_setup
case "$gh_setup" in
	[yY][eE][sS]|[yY])
		read -p "Github Email Address: " gh_email
		read -p "Github Username: " gh_name
		git config --global user.email "$gh_email"
		git config --global user.name "$gh_name"
		echo -e "\n"
		;;
	[nN][oO]|[nN])
		break
		;;
	*)
		echo "Invalid input. If you wish to setup git config, please run {git config --global user.name "[git username]" && git config --global user.email [email]}"
		;;
esac

read -p "Add Network Storage mount? [Y]es [N]o : " nas_setup
case "$nas_setup" in
	[yY][eE][sS]|[yY])
		source $HOME/dotfiles/scripts/nas-setup.sh
		;;
	[nN][oO]|[nN])
		break
		;;
	*)
		echo "Invalid input. If you wish to run the Network Storage setup, please run {. $HOME/dotfiles/scripts/nas_setup.sh}"
		;;
esac
