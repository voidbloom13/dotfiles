#!/bin/bash

# This script goes through installing all of my default programs.

# Initial update/upgrade and installs initial software
sudo apt update && 
sudo apt upgrade -y && 
sudo apt-get install -y cifs-utils curl default-jdk gcc gh git kitty maven neofetch nodejs npm python3 python3-pip python3-venv tmux tree unzip zsh

# Installs most recent version of nvim and VS Code from Snap
if [ -f /etc/apt/preferences.d/nosnap.pref ]; then
	sudo rm /etc/apt/preferences.d/nosnap.pref
fi
sudo apt update && sudo apt install -y snapd
sudo systemctl start snapd && sudo systemctl enable snapd
sudo snap install nvim --classic
sudo snap install code --classic

# Installs the .NET SDK
sudo apt install ca-certificates libc6 libgcc-s1 libicu74 liblttng-ust1 libssl3 libstdc++6 zlib1g
sudo add-apt-repository ppa:dotnet/backports
sudo apt-get update && 
sudo apt-get install -y dotnet-sdk-9.0

# Installs Google Chrome
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

# Installs favorite nerd fonts
source $HOME/dotfiles/scripts/install-fonts.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/IosevkaTerm.zip
source $HOME/dotfiles/scripts/install-fonts.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
source $HOME/dotfiles/scripts/install-fonts.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Lilex.zip
source $HOME/dotfiles/scripts/install-fonts.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Mononoki.zip
source $HOME/dotfiles/scripts/install-fonts.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/VictorMono.zip
source $HOME/dotfiles/scripts/install-fonts.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/ZedMono.zip

# Creates symlinks for dotfiles
source $HOME/dotfiles/scripts/mklinks.sh

# Cleanup
sudo apt update && sudo nala upgrade -y
sudo apt-get clean
sudo apt-get autoclean
sudo apt-get autoremove

# Sources .bashrc, uncomment if using bash as default shell
. $HOME/dotfiles/.bashrc

# Misc
clear && neofetch $$ echo "Next Steps:\n- Change shell to zsh [chsh]\n- Run [git config --global user.name {username} && git config --global user.email {email}]\n- Run [gh auth login]"
