#!/bin/bash

# This script goes through installing all of my default programs.

# Initial update/upgrade and installs nala
sudo apt update && sudo apt upgrade -y && sudo apt-get install -y nala

# Initial nala installs
sudo nala install -y cifs-utils curl default-jdk gcc gh git maven neofetch nodejs npm python3 python3-pip python3-venv  tree unzip

# Installs most recent version of nvim and VS Code from Snap
if [ -f /etc/apt/preferences.d/nosnap.pref ]; then
	sudo rm /etc/apt/preferences.d/nosnap.pref
fi
sudo nala update && sudo nala install -y snapd
sudo systemctl start snapd && sudo systemctl enable snapd
sudo snap install nvim --classic
sudo snap install code --classic

# Installs Node Version Manager (NVM)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# Installs Typescript
sudo npm install -g typescript

# Clones tmux/tpm
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

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

# Cleanup
sudo nala update && sudo nala upgrade -y
sudo apt-get clean
sudo apt-get autoclean
sudo apt-get autoremove

. $HOME/dotfiles/.bashrc
