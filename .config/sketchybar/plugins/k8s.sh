#!/bin/bash

source $CONFIG_DIR/plugins/extend-bin-path.sh
source $CONFIG_DIR/plugins/colors.sh

cfg="$(~/bin/cloud-config.sh k8s show)"
set_env_color $cfg

sketchybar --set "$NAME" label="$cfg" label.color=$env_color
