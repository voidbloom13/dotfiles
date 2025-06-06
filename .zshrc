# ZINIT DIRECTORY
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# BOOTSTRAP ZINIT
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
fi

# SOURCE ZINIT
source "${ZINIT_HOME}/zinit.zsh"

# PLUGINS
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# KEYBINDS
bindkey '^ ' autosuggest-accept
bindkey 'down' history-search-forward
bindkey 'up' history-search-backward

# HISTORY
HISTSIZE=5000
HISTFILE=$HOME/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# COMPLETION
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ALIASES
alias ls='ls -a --color'
alias neofetch="fastfetch"

# SHELL INTEGRATIONS
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# PROMPT STYLE
# Bootstraps Oh-My-Posh
export PATH=$PATH:$HOME/.local/bin
if [[ -z "$(command -v oh-my-posh)" ]]; then
    curl -s https://ohmyposh.dev/install.sh | bash -s
fi

# Sets Prompt Theme
eval "$(oh-my-posh init zsh --config "$HOME/dotfiles/omp-themes/void_catppuccin.omp.toml")"

# Runs Fastfetch on open
clear && fastfetch
