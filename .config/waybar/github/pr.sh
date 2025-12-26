#!/usr/bin/env bash

CATEGORY="$1"

case "$CATEGORY" in
  "created") GH_FLAG="--author" ;;
  "requested") GH_FLAG="--review-requested" ;;
  "reviewed") GH_FLAG="--reviewed-by" ;;
  *) echo '{"text": "!", "tooltip": "Invalid category", "class": "error"}'; exit 1 ;;
esac

CACHE_PATH="$HOME/.cache/waybar-gh-pr"
FILE_PATH="$CACHE_PATH/pr-$CATEGORY-list.json"
mkdir -p "$CACHE_PATH"

PR_DATA=$(gh search prs $GH_FLAG=@me --state=open --json number,title,repository,url,author)

if [ $? -ne 0 ]; then
  echo '{"text": "!", "tooltip": "gh CLI error", "class": "error"}'
  exit 0
fi

echo "$PR_DATA" > "$FILE_PATH"

PR_COUNT=$(echo "$PR_DATA" | jq 'length')

# Class and tooltip logic
if [ "$PR_COUNT" -lt 1 ]; then
  CLASS="none"
elif [ "$PR_COUNT" -le 3 ]; then
  CLASS="few"
else
  CLASS="many"
fi

TOOLTIP=$(echo "$PR_DATA" | jq -r '.[] | "[\(.repository.name)] \(.author.login) - #\(.number) \(.title)"' | head -n 10 | paste -sd "\n")

echo "{
  \"text\": \"$PR_COUNT\",
  \"tooltip\": \"$TOOLTIP\",
  \"class\": \"$CLASS\"
}" | jq --unbuffered --compact-output
