#!/bin/bash

# Define the target space where SAFARI should be moved (e.g., space 4)
TARGET_SPACE=2

# Get the ID of the Safari window
SAFARI_WINDOW_ID=$(yabai -m query --windows | jq -r '.[] | select(.app == "Google Chrome") | .id')

# Exit if no SAFARI window is found
if [[ -z $SAFARI_WINDOW_ID ]]; then
    yabai -m space --focus 2
    exit 0
fi

# Get the space where Safari is currently located
SAFARI_CURRENT_SPACE=$(yabai -m query --windows --window $SAFARI_WINDOW_ID | jq -r '.space')

# Check if Safari is already in the target space
if [[ $SAFARI_CURRENT_SPACE -eq $TARGET_SPACE ]]; then
    # Focus the target space and exit
    yabai -m space --focus $TARGET_SPACE
    exit 0
else
    # Move Safari to the target space and focus it
    yabai -m window $SAFARI_WINDOW_ID --space $TARGET_SPACE
    yabai -m space --focus $TARGET_SPACE
    exit 0
fi
