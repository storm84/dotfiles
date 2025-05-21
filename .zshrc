# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="nanotech"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-vi-mode)

source $ZSH/oh-my-zsh.sh

export EDITOR=nvim

# wifi script
# alias wifi="~/.config/wofi/scripts/wifi_connect.sh"

# docker
alias dps="docker ps --format '{{.Names}}\t{{.ID}}\t{{.Status}}'"
alias dpsl="docker ps --format '{{.Names}}\n\tContainer ID: {{.ID}}\n\tCommand: {{.Command}}\n\tImage: {{.Image}}\n\tCreatedAt: {{.CreatedAt}}\n\tStatus: {{.Status}}'"

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

# git
alias git-clean-branches='git fetch --prune && git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}"'

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


# if [[ "$(uname -s)" == "Linux" ]]; then
#   source /usr/share/nvm/init-nvm.sh
# fi

# istioctl
export PATH=$HOME/.istioctl/bin:$PATH

# vpn
alias vpn="vpn.sh"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
