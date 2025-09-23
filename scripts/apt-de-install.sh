#!/bin/bash

# This script goes through installing all of my default programs.

# Initial update/upgrade and installs initial software
sudo apt update && 
sudo apt upgrade -y && 
sudo apt-get install -y build-essential cifs-utils curl default-jdk gcc gh git kitty maven neofetch nodejs npm python3 python3-pip python3-venv ripgrep tmux tree unzip zoxide zsh

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
sudo snap install code --classic

# Installs NvChad alongside current config. Setup alias using the following in .zshrc or .bashrc/.bashaliases: alias [aliasName]="NVIM_APPNAME=[dirName] nvim"
git clone https://github.com/NvChad/starter ~/dotfiles/nvchad

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
curl -O https://github.com/obsidianmd/obsidian-releases/releases/download/v1.9.12/obsidian_1.9.12_amd64.deb
sudo dpkg -i obsidian_1.9.12_amd64.deb
rm obsidian_1.9.12_amd64.deb

# Installs Node Version Manager (NVM) and NodeJS LTS
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
nvm install --lts
nvm use --lts

# Installs Typescript
sudo npm install -g nodemon typescript

# Downloads catppuccin theme for tmux
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux

# Clones tmux/tpm
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# Installs favorite nerd fonts
source $HOME/dotfiles/scripts/install-fonts.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/CommitMono.zip
source $HOME/dotfiles/scripts/install-fonts.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Inconsolata.zip
source $HOME/dotfiles/scripts/install-fonts.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/IosevkaTerm.zip
source $HOME/dotfiles/scripts/install-fonts.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
source $HOME/dotfiles/scripts/install-fonts.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Lekton.zip
source $HOME/dotfiles/scripts/install-fonts.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Lilex.zip
source $HOME/dotfiles/scripts/install-fonts.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Mononoki.zip
source $HOME/dotfiles/scripts/install-fonts.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/NerdFontSymbolsOnly.zip
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
clear && neofetch $$ echo "Next Steps:\n- Run tmux and press [<ctrl> + b, i] to install tpm plugins\n- Change shell to zsh [chsh]\n- Run [git config --global user.name {username} && git config --global user.email {email}]\n- Run [gh auth login]"
