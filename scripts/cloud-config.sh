#!/bin/bash

# <script> <action> <config-provider> (opts)
# cfg k8s show
# cfg k8s set 
# cfg gcp show
# cfg gcp set

# Name of the script
SCRIPT=$( basename "$0" )

# Current version
VERSION="1.0.0"

gcp_prompt="select gcloud config:"
k8s_prompt="select k8s context:"

function usage
{
    local txt=(
    "$SCRIPT is a tool to quickly change (and show) the active config/context for kubctl and gcloud."
"Usage: $SCRIPT <tool> <action> [options]"
""
"Tool:"
"  k8s                  kubernetes (kubctl)"
"  gcp                  google cloud (gcloud)"
"Action:"
"  show                 Shows the active config for the tool."
"  set                  Uses a selection tool to select the config to be set as active"
""
"Options:"
"  -h     Print help."
"  -v     Verbose output (used for show action)"
"  -p     set selection tool to be used [choose, gum, fzf] (if not set any of the listed will be used if installed)"
""
"Example:"
"$SCRIPT k8s show -v      # will show the active contexts for kubectl with verbose output"
"$SCRIPT gcp set -p fzf   # will set the active config for gcloude using fzf to select the config"
    )

    printf "%s\\n" "${txt[@]}"
}

gcp_cfgs(){
  gcloud config configurations list | awk 'NR>1 { print $1 }'
}

k8s_cfgs(){
  kubectl config get-contexts | sed "s/\*//" | awk 'NR>1 { print $1 }'
}

gcp_show_active(){
  if [[ "$verbose" = true ]]; then
    description="gcloud active config: "
  fi
  echo "$description$(gcloud config configurations list | grep True | sed "s/ .*//")"
}

k8s_show_active(){
  if [[ "$verbose" = true ]]; then
    description="kubectl active context: "
  fi
  echo "$description$(kubectl config get-contexts | grep "*" | awk '{ print $2 }')"
}

show_active(){
  case "$tool" in
    gcp) gcp_show_active 
    ;;
    k8s) k8s_show_active
    ;;
    *) echo "invalid tool"
       exit 1
    ;;
  esac
}

set_active(){
  case "$tool" in
    gcp) gcloud config configurations activate $(select_config) 
    ;;
    k8s) kubectl config use-context $(select_config) 
    ;;
    *) echo "invalid tool"
       exit 1
    ;;
  esac
}

use_fzf(){
  echo "$cfgs" | fzf --header="$PROMPT"
}

use_gum(){
  gum choose --header="$PROMPT" $cfgs 
}

use_choose(){
  echo "$cfgs" | choose -p "$PROMPT"
}

use_any_installed(){
  if hash choose 2>/dev/null; then
    use_choose
  elif hash gum 2>/dev/null; then
    use_gum
  elif hash fzf 2>/dev/null; then
    use_fzf
  else
    echo "required tool not installed, you need to have choose or gum or fzf installed for the script to work"
    exit 1
  fi
}


select_config(){
  case "$tool" in
    gcp) 
      PROMPT=$gcp_prompt
      cfgs=$(gcp_cfgs)
    ;;
    k8s)
      PROMPT=$k8s_prompt
      cfgs=$(k8s_cfgs)
    ;;
    *) echo "invalid tool"
       exit 1
    ;;
  esac
  
  case "$picker" in
    fzf) use_fzf
    ;;
    gum) use_gum
    ;;
    choose) use_choose
    ;;
    "") use_any_installed
    ;;
    *) 
      echo "Invalid picker -p argument"
      exit 1
    ;;
  esac
}

tool=$1
action=$2
shift 2

while getopts 'hvp:' OPTION ; do
  case "$OPTION" in
    p) picker=$OPTARG 
    ;;
    v) verbose=true
    ;;
    h) usage
       exit 0
    ;;
    *) exit 1
    ;;
  esac
done

case "$action" in
  show) show_active
    exit 0
  ;;
  set) set_active
    exit 0
  ;;
  *) echo "invalid action" 
    exit 1
  ;;
esac

