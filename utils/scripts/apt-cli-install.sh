#!/bin/bash

# Installation walkthrough for wsl or headless apt-based systems.

# Initial update/upgrade and installs initial software
sudo apt update && 
sudo apt upgrade -y && 
sudo apt-get install -y build-essential cifs-utils curl default-jdk gcc gh git maven nala neofetch nodejs npm python3 python3-pip python3-venv ripgrep stow tmux tree unzip zoxide zsh

# Installs latest fzf
rm -rf ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
cd ~/.fzf && git pull && ./install

# Installs most recent version of nvim and VS Code from Snap
if [ -f /etc/apt/preferences.d/nosnap.pref ]; then
  sudo rm /etc/apt/preferences.d/nosnap.pref
fi
sudo apt update && sudo apt install -y snapd
sudo systemctl start snapd && sudo systemctl enable snapd
sudo snap install nvim --classic

# Detects if in WSL environment before installing VS Code
if [[ $(uname -r) =~ WSL ]]; then
  sudo snap install code --classic
fi

# Installs the .NET SDK
sudo apt install ca-certificates libc6 libgcc-s1 libicu74 liblttng-ust1 libssl3 libstdc++6 zlib1g
sudo add-apt-repository ppa:dotnet/backports
sudo apt-get update && 
sudo apt-get install -y dotnet-sdk-9.0

# Installs Node Version Manager (NVM) and NodeJS LTS
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
nvm install --lts
nvm use --lts

# Installs NPM Packages
sudo npm install -g nodemon typescript typescript-language-server @tailwindcss/language-server

# Downloads catppuccin theme for tmux
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux

# Clones tmux/tpm
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# Creates symlinks for dotfiles
source $HOME/dotfiles/utils/scripts/stow.sh

# Cleanup
sudo apt update && sudo nala upgrade -y
sudo apt-get clean
sudo apt-get autoclean
sudo apt-get autoremove

# Sources .bashrc, uncomment if using bash as default shell
. $HOME/dotfiles/.bashrc

# Misc
cd && clear && neofetch && echo "Complete TMUX setup by running TMUX and pressing <C-b><i> to install TPM plugins. Please make sure to change user shell to zsh with chsh. Setup git config --global user.name and user.email. Authorize github using [gh auth login]."
