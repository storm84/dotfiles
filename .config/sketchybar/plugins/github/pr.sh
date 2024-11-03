#!/usr/bin/env bash

case "$1" in
  "created")
    GH_FLAG="--author"
    ;;
  "requested")
    GH_FLAG="--review-requested"
    ;;
  "reviewed")
    GH_FLAG="--reviewed-by"
    ;;
  *)
    exit 1
    ;;
esac

source $CONFIG_DIR/plugins/colors.sh

# Setup the .cache directory path
CACHE_PATH="$HOME/.cache/sketchybar/gh-pr"

# Ensure the .cache directory exists
mkdir -p "$CACHE_PATH"

# Define the file path directory
FILE_PATH="$CACHE_PATH/pr-$1-list.json"

# Fetch PR details and calculate the count in a single call
PR_DATA=$(gh search prs $GH_FLAG=@me --state=open --json number,title,repository,url,author)

# Overwrite the json file with the latest PR data
echo "$PR_DATA" > "$FILE_PATH"

# Calculate PR count using jq
PR_COUNT=$(echo "$PR_DATA" | jq '. | length')

# Set icon color based on PR count and dont draw the item on zero
DRAWING=on
if [ "$PR_COUNT" -lt 1 ]; then
  LABEL_COLOR=$c_white
  DRAWING=off
elif [ "$PR_COUNT" -le 3 ]; then
  LABEL_COLOR=$c_white
else
  LABEL_COLOR=$c_red
fi

# Update SketchyBar with the icon color and PR count label
sketchybar --set github-pr-$1 drawing=$DRAWING label.color="$LABEL_COLOR" label="$PR_COUNT"
