#!/bin/bash

# Define the space where you want to check and move Alacritty (e.g., space 4)
TARGET_SPACE=4

# Get the ID of the Alacritty window
ALACRITTY_WINDOW_ID=$(yabai -m query --windows | jq -r '.[] | select(.app == "Alacritty") | .id')

# Get the current space
CURRENT_SPACE=$(yabai -m query --spaces --space | jq -r '.index')

# Get the space where Alacritty is currently located
ALACRITTY_CURRENT_SPACE=$(yabai -m query --windows --window $ALACRITTY_WINDOW_ID | jq -r '.space')

# Check if we are moving to the target space
if [[ $CURRENT_SPACE -eq $TARGET_SPACE ]]; then
    # Check if Alacritty is already in the target space
    if [[ $ALACRITTY_CURRENT_SPACE -ne $TARGET_SPACE ]]; then
        # If Alacritty is not in the target space, move it to the target space
        yabai -m window $ALACRITTY_WINDOW_ID --space $TARGET_SPACE
        yabai -m window --focus $ALACRITTY_WINDOW_ID
    fi
fi
