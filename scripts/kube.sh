#!/bin/bash

PROMPT="select k8s context:"

show_active(){
  echo "kubectl active context: $(kubectl config get-contexts | grep "*" | awk '{ print $2 }')"
}

use_fzf(){
  echo "$1" | fzf --header="$PROMPT"
}

use_gum(){
  gum choose --header="$PROMPT" $1 
}

use_choose(){
  echo "$1" | choose -p "$PROMPT"
}

use_if_exists(){
  if hash choose 2>/dev/null; then
    use_choose "$1"
  elif hash gum 2>/dev/null; then
    use_gum "$1"
  elif hash fzf 2>/dev/null; then
    use_fzf "$1"
  else
    echo "required tool not installed, you need to have choose or gum or fzf installed for the script to work"
    exit 0
  fi
}

select_config(){
  cfgs=$(kubectl config get-contexts | sed "s/\*//" | awk 'NR>1 { print $1 }')
 
  case "$1" in
    fzf) use_fzf "$cfgs"
    ;;
    gum) use_gum "$cfgs" 
    ;;
    choose) use_choose "$cfgs"
    ;;
    "") use_if_exists "$cfgs"
    ;;
    *) 
      echo "Invalid picker -p argument"
      exit 0
    ;;
  esac
}

while getopts 'sp:' OPTION ; do
  case "$OPTION" in
    s) show_active
       exit 1
    ;;
    p) picker=$OPTARG 
    ;;
    *) exit 0
    ;;
  esac
done

kubectl config use-context $(select_config $picker) 
# echo $(select_config $picker)

