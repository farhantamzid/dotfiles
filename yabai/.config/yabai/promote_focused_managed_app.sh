#!/bin/bash

# Get the focused window's app
focused_app=$(yabai -m query --windows --window | jq -r '.app')

# Bring that app to the front
osascript -e "tell application \"$focused_app\" to activate"
