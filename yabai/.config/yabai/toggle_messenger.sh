#!/bin/bash

# Define the space where Alacritty should always reside (e.g., space 2)
MESSENGER_SPACE=5

# Get the ID of the currently focused space
CURRENT_SPACE=$(yabai -m query --spaces --space | jq -r '.index')

# Get the ID of the Alacritty window
MESSENGER_WINDOW_ID=$(yabai -m query --windows | jq -r '.[] | select(.app == "Messenger") | .id')

# Check if Alacritty is already in the current space
IS_MESSENGER_IN_CURRENT_SPACE=$(yabai -m query --windows --space | jq -r ".[] | select(.id == $MESSENGER_WINDOW_ID) | .id")

if [[ $IS_MESSENGER_IN_CURRENT_SPACE == $MESSENGER_WINDOW_ID ]]; then
    # If Alacritty is in the current space, move it back to its assigned space
    yabai -m window $MESSENGER_WINDOW_ID --space $MESSENGER_SPACE
else
    # If Alacritty is not in the current space, move it to the current space
    yabai -m window $MESSENGER_WINDOW_ID --space $CURRENT_SPACE
    yabai -m window --focus $MESSENGER_WINDOW_ID

fi