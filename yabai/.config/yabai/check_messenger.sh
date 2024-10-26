#!/bin/bash

# Define the target space where Alacritty should be moved (e.g., space 4)
TARGET_SPACE=5

# Get the ID of the Alacritty window
MESSENGER_WINDOW_ID=$(yabai -m query --windows | jq -r '.[] | select(.app == "Messenger") | .id')

# Exit if no Alacritty window is found
if [[ -z $MESSENGER_WINDOW_ID ]]; then
    yabai -m space --focus 5
    exit 0
fi

# Get the space where Alacritty is currently located
MESSENGER_CURRENT_SPACE=$(yabai -m query --windows --window $MESSENGER_WINDOW_ID | jq -r '.space')

# Check if Alacritty is already in the target space
if [[ $MESSENGER_CURRENT_SPACE -eq $TARGET_SPACE ]]; then
    # Focus the target space and exit
    yabai -m space --focus $TARGET_SPACE
    exit 0
else
    # Move Alacritty to the target space and focus it
    yabai -m window $MESSENGER_WINDOW_ID --space $TARGET_SPACE
    yabai -m space --focus $TARGET_SPACE
    exit 0
fi
