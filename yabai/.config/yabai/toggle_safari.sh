#!/bin/bash

# Define the space where safari should always reside (e.g., space 2)
SAFARI_SPACE=2

# Get the ID of the currently focused space
CURRENT_SPACE=$(yabai -m query --spaces --space | jq -r '.index')

# Get the ID of the SAFARI window
SAFARI_WINDOW_ID=$(yabai -m query --windows | jq -r '.[] | select(.app == "Google Chrome") | .id')

# Check if SAFARI is already in the current space
IS_SAFARI_IN_CURRENT_SPACE=$(yabai -m query --windows --space | jq -r ".[] | select(.id == $SAFARI_WINDOW_ID) | .id")

if [[ $IS_SAFARI_IN_CURRENT_SPACE == $SAFARI_WINDOW_ID ]]; then
    # If SAFARI is in the current space, move it back to its assigned space
    yabai -m window $SAFARI_WINDOW_ID --space $SAFARI_SPACE
else
    # If SAFARI is not in the current space, move it to the current space
    yabai -m window $SAFARI_WINDOW_ID --space $CURRENT_SPACE
    yabai -m window --focus $SAFARI_WINDOW_ID

fi