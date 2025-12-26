#!/usr/bin/env bash

CATEGORY="$1"

case "$CATEGORY" in
  "created") PROMPT="Select PR created by @me" ;;
  "requested") PROMPT="Select PR requesting review" ;;
  "reviewed") PROMPT="Select PR reviewed by @me" ;;
  *) echo "Invalid category"; exit 1 ;;
esac

CACHE_PATH="$HOME/.cache/waybar-gh-pr"
FILE_PATH="$CACHE_PATH/pr-$CATEGORY-list.json"

[ ! -f "$FILE_PATH" ] && echo "No cached PRs" && exit 1

DATA=$(<"$FILE_PATH")

# Build menu: one line per PR
PR_LIST=$(echo "$DATA" | jq -r '.[] | "[\(.repository.name)] \(.author.login) - #\(.number) \(.title)"')

SELECTED=$(echo "$PR_LIST" | wofi --dmenu --width 800 --height 400 --prompt "$PROMPT") || exit 1

NUMBER=$(echo "$SELECTED" | grep -oE '#[0-9]+' | tr -d '#')

# Find and open URL
URL=$(echo "$DATA" | jq -r ".[] | select(.number == $NUMBER) | .url")

[ -n "$URL" ] && xdg-open "$URL"
