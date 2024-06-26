#!/bin/bash

# Define the target space where CODE should be moved (e.g., space 4)
TARGET_SPACE=3

# Get the ID of the CODE window
CODE_WINDOW_ID=$(yabai -m query --windows | jq -r '.[] | select(.app == "Code") | .id')

# Exit if no CODE window is found
if [[ -z $CODE_WINDOW_ID ]]; then
    yabai -m space --focus 3
    exit 0
fi

# Get the space where CODE is currently located
CODE_CURRENT_SPACE=$(yabai -m query --windows --window $CODE_WINDOW_ID | jq -r '.space')

# Check if CODE is already in the target space
if [[ $CODE_CURRENT_SPACE -eq $TARGET_SPACE ]]; then
    # Focus the target space and exit
    yabai -m space --focus $TARGET_SPACE
    exit 0
else
    # Move CODE to the target space and focus it
    yabai -m window $CODE_WINDOW_ID --space $TARGET_SPACE
    yabai -m space --focus $TARGET_SPACE
    exit 0
fi
