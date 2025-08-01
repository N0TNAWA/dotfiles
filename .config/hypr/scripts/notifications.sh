#!/bin/bash

JSON_FILE="$HOME/.cache/notifications.json"
MAX_HISTORY=5


# Ensure JSON file exists
[ -f "$JSON_FILE" ] || echo "[]" > "$JSON_FILE"

# Pull from Dunst's environment and escape double quotes properly
icon=$(printf "%s" "$DUNST_ICON_PATH" | sed 's/"/\\"/g')
id=$(printf "%s" "$DUNST_ID" | sed 's/"/\\"/g')
app=$(printf "%s" "$DUNST_APP_NAME" | sed 's/"/\\"/g')
summary=$(printf "%s" "$DUNST_SUMMARY" | sed 's/"/\\"/g')
body=$(printf "%s" "$DUNST_BODY" | sed 's/"/\\"/g')
timestamp=$(date --iso-8601=seconds)

echo "appname: $app, icon: $icon, id: $id, summary: $summary, body: $body, timestamp: $timestamp"

# Create new JSON entry
new_entry=$(jq -n \
  --arg icon "$icon" \
  --arg id "$id" \
  --arg app "$app" \
  --arg time "$timestamp" \
  --arg summary "$summary" \
  --arg body "$body" \
  '{timestamp: $time, appname: $app, id: $id, summary: $summary, body: $body, icon: $icon}')

# Prepend new entry and trim history
tmp=$(mktemp)
jq --argjson new "$new_entry" --argjson max "$MAX_HISTORY" \
  '[$new] + . | .[:$max]' "$JSON_FILE" > "$tmp" && mv "$tmp" "$JSON_FILE"
