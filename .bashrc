# Adds the contents of any existing .bash_alias files to $HOME/dotfiles/.bash_aliases
if [ -f $HOME/.bash_aliases ]; then
    mv $HOME/dotfiles/.bash_aliases $HOME/dotfiles/.bash_aliases.tmp
    cat $HOME/.bash_aliases $HOME/dotfiles/.bash_aliases.tmp | sort | uniq | grep -v '^$' > $HOME/dotfiles/.bash_aliases
    rm $HOME/dotfiles/.bash_aliases.tmp
fi
source $HOME/dotfiles/.bash_aliases

# General settings
export EDITOR=vim
export HISTCONTROL=ignoredups
export PATH="$PATH:/snap/bin"

# Default PS1 Prompt
PROMPT_COMMAND='PS1_CMD1=$(git branch --show-current 2>/dev/null)';
PS1='\[\e[38;5;33m\]\d\[\e[0m\] \[\e[38;5;33m\]|\[\e[0m\] \[\e[38;5;33m\]\t\[\e[0m\] \[\e[95m\]\u@\h\n\[\e[91m\]\w\[\e[38;5;220m\][${PS1_CMD1}]\[\e[0m\] \[\e[38;5;92m\]\$\[\e[0m\]'

# Bootstraps Oh-My-Posh
export PATH=$PATH:$HOME/.local/bin
if [[ -z "$(command -v oh-my-posh)" ]]; then
    curl -s https://ohmyposh.dev/install.sh | bash -s
fi
eval "$(oh-my-posh init bash --config "$HOME/dotfiles/omp-themes/void_catppuccin.omp.toml")"
