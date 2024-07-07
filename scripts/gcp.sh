#!/bin/bash

PROMPT="select gcloud config:"

show_active(){
  echo "gcloud active config: $(gcloud config configurations list | grep True | sed "s/ .*//")"
}

set_active(){
  gcloud config configurations activate $(gum choose --header="select gcloud config:" $(gcloud config configurations list | awk 'NR>1 { print $1 }'))
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
  cfgs=$(gcloud config configurations list | awk 'NR>1 { print $1 }')
  
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

gcloud config configurations activate $(select_config $picker) 
# echo $(select_context $picker)

