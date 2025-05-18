#!/bin/bash

# Get list of all windows on the current space
windows=$(yabai -m query --windows --space)

# Use jq to extract needed fields safely
echo "$windows" | jq -c '.[]' | while read -r win; do
  app=$(echo "$win" | jq -r '.app')
  is_managed=$(echo "$win" | jq -r '.["is-managed"]')
  has_focus=$(echo "$win" | jq -r '.["has-focus"]')

  if [[ "$is_managed" == "false" && "$has_focus" == "false" ]]; then
    osascript -e "tell application \"System Events\" to set frontmost of process \"$app\" to false"
  fi
done
