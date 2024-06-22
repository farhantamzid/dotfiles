#!/bin/bash


CODE_SPACE=3

# Get the ID of the currently focused space
CURRENT_SPACE=$(yabai -m query --spaces --space | jq -r '.index')

# Get the ID of the CODE window
CODE_WINDOW_ID=$(yabai -m query --windows | jq -r '.[] | select(.app == "Code") | .id')

# Check if CODE is already in the current space
IS_CODE_IN_CURRENT_SPACE=$(yabai -m query --windows --space | jq -r ".[] | select(.id == $CODE_WINDOW_ID) | .id")

if [[ $IS_CODE_IN_CURRENT_SPACE == $CODE_WINDOW_ID ]]; then
    # If CODE is in the current space, move it back to its assigned space
    yabai -m window $CODE_WINDOW_ID --space $CODE_SPACE
else
    # If CODE is not in the current space, move it to the current space
    yabai -m window $CODE_WINDOW_ID --space $CURRENT_SPACE
    yabai -m window --focus $CODE_WINDOW_ID

fi