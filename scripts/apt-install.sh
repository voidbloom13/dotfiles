#!/bin/bash

# This script goes through installing all of my default programs.

# Initial update/upgrade and installs nala
sudo apt update && sudo apt upgrade -y && sudo apt-get install -y nala

# Initial nala installs
sudo nala install -y cifs-utils curl default-jdk gcc gh git kitty maven neofetch nodejs npm python3 python3-pip python3-venv tmux tree unzip

# Installs most recent version of nvim and VS Code from Snap
if [ -f /etc/apt/preferences.d/nosnap.pref ]; then
	sudo rm /etc/apt/preferences.d/nosnap.pref
fi
sudo nala update && sudo nala install -y snapd
sudo systemctl start snapd && sudo systemctl enable snapd
sudo snap install nvim --classic
sudo snap install code --classic

# Installs Google Chrome (I know, why use Linux and then install Chrome... I like Chrome.)
mkdir /etc/apt/keyrings
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo tee /etc/apt/keyrings/google.asc > /dev/null
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google.asc] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get install google-chrome-stable

# Installs Obsidian
curl -O https://github.com/obsidianmd/obsidian-releases/releases/download/v1.8.10/obsidian_1.8.10_amd64.deb
sudo dpkg -i obsidian_1.8.10_amd64.deb
rm obsidian_1.8.10_amd64.deb

# Installs Node Version Manager (NVM) and NodeJS LTS
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
nvm install --lts
nvm use --lts

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

# Optionally, installs my favorite nerd fonts
read -p "Would you like to install the following nerdfonts? { IosevkaTerm, Jetbrains Mono, Lilex, Mononoki, Victor Mono, Zed Mono } [Y]es [N]o : " install_fonts
case "$install_fonts" in
	[yY][eE][sS]|[yY])
		source $HOME/dotfiles/scripts/install-fonts.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/IosevkaTerm.zip
		source $HOME/dotfiles/scripts/install-fonts.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
		source $HOME/dotfiles/scripts/install-fonts.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Lilex.zip
		source $HOME/dotfiles/scripts/install-fonts.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Mononoki.zip
		source $HOME/dotfiles/scripts/install-fonts.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/VictorMono.zip
		source $HOME/dotfiles/scripts/install-fonts.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/ZedMono.zip
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
