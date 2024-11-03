#!/usr/bin/env bash

case "$1" in
  "created")
    PROMPT="select open pr created by @me"
    ;;
  "requested")
    PROMPT="select open pr requesting review by @me"
    ;;
  "reviewed")
    PROMPT="select open pr reviewed by @me"
    ;;
  *)
    exit 1
    ;;
esac

# Setup the .cache directory path
CACHE_PATH="$HOME/.cache/sketchybar/gh-pr"

# Define the file path directory
FILE_PATH="$CACHE_PATH/pr-$1-list.json"

# Check if the json file exists
if [ ! -f "$FILE_PATH" ]; then
  echo "PR list file not found at $FILE_PATH"
  exit 1
fi

DATA=$(<$FILE_PATH)

# use choose to select PR, exit if none chosen
SELECTED=$(echo $DATA | jq -r '.[] | "[\(.repository.name)] \(.author.login) - #\(.number) \(.title)"' | choose -i -p "$PROMPT") \
  || exit 1

# get the URL from the selected json array item
URL=$(echo $DATA | jq -r ".[$SELECTED].url")
open "$URL"

