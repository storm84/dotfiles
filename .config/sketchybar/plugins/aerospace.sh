source $CONFIG_DIR/plugins/icon_map.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.drawing=on
else
    sketchybar --set $NAME background.drawing=off
fi