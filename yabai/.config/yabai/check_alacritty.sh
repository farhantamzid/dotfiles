#!/bin/bash

# Define the target space where Alacritty should be moved (e.g., space 4)
TARGET_SPACE=4

# Get the ID of the Alacritty window
ALACRITTY_WINDOW_ID=$(yabai -m query --windows | jq -r '.[] | select(.app == "Alacritty") | .id')

# Exit if no Alacritty window is found
if [[ -z $ALACRITTY_WINDOW_ID ]]; then
  yabai -m space --focus 4
  exit 0
fi

# Get the space where Alacritty is currently located
ALACRITTY_CURRENT_SPACE=$(yabai -m query --windows --window $ALACRITTY_WINDOW_ID | jq -r '.space')

# Check if Alacritty is already in the target space
if [[ $ALACRITTY_CURRENT_SPACE -eq $TARGET_SPACE ]]; then
  # Focus the target space and exit
  yabai -m space --focus $TARGET_SPACE
  exit 0
else
  # Move Alacritty to the target space and focus it
  yabai -m window $ALACRITTY_WINDOW_ID --space $TARGET_SPACE
  yabai -m space --focus $TARGET_SPACE
  exit 0
fi
