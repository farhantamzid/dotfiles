#!/bin/bash

# Get focused window info
focused_window=$(yabai -m query --windows --window)

# Check if the window is managed
is_managed=$(echo "$focused_window" | jq -r '.["is-floating"]' | grep -q false && echo true || echo false)

# Exit if the focused window is not managed
if [[ "$is_managed" != "true" ]]; then
    exit 0
fi

# Get the app name of the focused window
focused_app=$(echo "$focused_window" | jq -r '.app')

# Get all apps on the current space (filtering out duplicates)
apps_on_space=$(yabai -m query --windows --space | jq -r '.[].app' | sort -u)

# Hide all apps on the current space except the focused one
for app in $apps_on_space; do
    if [[ "$app" != "$focused_app" ]]; then
        osascript -e "tell application \"System Events\" to set visible of process \"$app\" to false" 2>/dev/null
    fi
done
