#!/bin/sh

if [ "$SENDER" = "space_windows_change" ] || [ "$SENDER" = "aerospace_workspace_change" ]; then
  source $CONFIG_DIR/plugins/icon_map.sh
  
  result=$(aerospace list-windows --all --format "%{workspace}-%{app-name}" | sort -u)
  workspaces=($(aerospace list-workspaces --all))

  for workspace in "${workspaces[@]}"; do
    matches=$(echo "$result" | grep "^$workspace-")

    icon_strip=""
    if [ "${matches}" != "" ]; then
      while IFS= read -r app_row; do
        app="${app_row#*-}" # Extract text right of the '-'
        __icon_map "$app"
        icon_strip+=" $icon_result"
      done <<< "${matches}"
    fi

    sketchybar --set space.$workspace label="$icon_strip"
  done 
fi
