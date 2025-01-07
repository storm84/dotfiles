

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="nanotech"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# alias cat="bat"

# wifi script
# alias wifi="~/.config/wofi/scripts/wifi_connect.sh"

# docker
alias dps="docker ps"

# dotnet
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$DOTNET_ROOT:$PATH:$DOTNET_ROOT/tools
alias dnt="dotnet test"

# nvim
alias vim=nvim


# GO
# export GOPATH=$HOME/go
#
#
# export GOPATH="$HOME/go"; export GOROOT="$HOME/.go"; export PATH="$GOPATH/bin:$PATH"; # g-install: do NOT edit, see https://github.com/stefanmaric/g
# alias govm="$GOPATH/bin/g"; # g-install: do NOT edit, see https://github.com/stefanmaric/g

# Taskfile runner
# alias task=go-task

# Startship prompt
eval "$(starship init zsh)"

# export PATH=$PATH:$HOME/.cargo/bin

# add local bin (pip)
# export PATH="${PATH}:${HOME}/.local/bin/"

# pywal
# (cat ~/.cache/wal/sequences &)

# ls
alias ls=eza

# vimgolf ruby gem path 
# export PATH=$PATH:$(ruby -e 'print Gem.user_dir')/gems/vimgolf-0.5.0/bin

# zsh
  eval "$(fzf --zsh)"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/marcusstorm/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/marcusstorm/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/marcusstorm/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/marcusstorm/google-cloud-sdk/completion.zsh.inc'; fi

# psql path
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# nvm 
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/Users/marcusstorm/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

alias zel=zellij
alias zl="zellij ls"
alias za="zellij a"

# add local bin folder to be used for scripts to path
export PATH="$HOME/bin:$PATH"

# gcloud and kubernetses aliases
alias config="cloud-config.sh"
alias k8s="cloud-config.sh k8s set -p fzf"
alias gcp="cloud-config.sh gcp set -p fzf"

# k9s
alias k9s="cloud-config.sh k8s set -p fzf && k9s"

# port-forward
alias kpf="cloud-config.sh k8s set -p fzf && port-forward.sh"
alias pf="port-forward.sh"

# munin-api
alias munin="munin-api.sh"

# github pr
alias prr="gh search prs --review-requested=@me --state=open --json title,state,author,url,updatedAt | jq -r '.[] | "\""[\(.updatedAt)] \(.author.login): [\(.title)](\(.url))"\""'"
alias prd="gh search prs --reviewed-by=@me --state=open --json title,state,author,url,updatedAt | jq -r '.[] | "\""[\(.updatedAt)] \(.author.login): [\(.title)](\(.url))"\""'"
alias prm="gh search prs --author=@me --state=open --json title,state,author,url,updatedAt | jq -r '.[] | "\""[\(.updatedAt)] \(.author.login): [\(.title)](\(.url))"\""'"

# github workflow run
alias ghr="gh workflow run --ref \$(git rev-parse --abbrev-ref HEAD)"
alias ghw="gh run watch"

# github copilot aliases (ghce ghcs)
eval "$(gh copilot alias -- zsh)"

export PATH="/opt/homebrew/opt/protobuf@3/bin:$PATH"

# Created by `pipx` on 2024-09-26 06:13:52
export PATH="$PATH:/Users/marcusstorm/.local/bin"

# run this only for mac for now (part of configuring python for nvim)
if [[ "$(uname -s)" == "Darwin" ]]; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# init zoxide
eval "$(zoxide init zsh)"

# atuin
if [[ "$(uname -s)" == "Darwin" ]]; then
  . "$HOME/.atuin/bin/env"
fi

eval "$(atuin init zsh)"

# reset_borders
alias reset_borders="kill "\""$(ps -ax | awk '/[b]orders/{print $1}')"\"" &> /dev/null | (borders active_color=0xfff6fecb inactive_color=0xff494d64 width=5.0 &)"

# source user .env file
set -a; source $HOME/.env; set +a


if [[ "$(uname -s)" == "Linux" ]]; then
  source /usr/share/nvm/init-nvm.sh
fi
