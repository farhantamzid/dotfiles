#!/bin/bash

# Define the space where Alacritty should always reside (e.g., space 2)
ALACRITTY_SPACE=4

# Get the ID of the currently focused space
CURRENT_SPACE=$(yabai -m query --spaces --space | jq -r '.index')

# Get the ID of the Alacritty window
ALACRITTY_WINDOW_ID=$(yabai -m query --windows | jq -r '.[] | select(.app == "Alacritty") | .id')

# Check if Alacritty is already in the current space
IS_ALACRITTY_IN_CURRENT_SPACE=$(yabai -m query --windows --space | jq -r ".[] | select(.id == $ALACRITTY_WINDOW_ID) | .id")

if [[ $IS_ALACRITTY_IN_CURRENT_SPACE == $ALACRITTY_WINDOW_ID ]]; then
    # If Alacritty is in the current space, move it back to its assigned space
    yabai -m window $ALACRITTY_WINDOW_ID --space $ALACRITTY_SPACE
else
    # If Alacritty is not in the current space, move it to the current space
    yabai -m window $ALACRITTY_WINDOW_ID --space $CURRENT_SPACE
    yabai -m window --focus $ALACRITTY_WINDOW_ID

fi