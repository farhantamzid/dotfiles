#!/bin/bash

STATE_MANAGED="$HOME/.config/yabai/.last_managed_window"
STATE_FLOAT="$HOME/.config/yabai/.last_floating_window"
CURRENT_ID="$1"

if [[ -z "$CURRENT_ID" ]]; then
  exit 0
fi

WINDOW_INFO=$(yabai -m query --windows --window "$CURRENT_ID" 2>/dev/null)

if [[ -z "$WINDOW_INFO" || "$WINDOW_INFO" == "null" ]]; then
  exit 0
fi

IS_FLOATING=$(echo "$WINDOW_INFO" | jq -r '."is-floating"')
PID=$(echo "$WINDOW_INFO" | jq -r '.pid')

if [[ "$IS_FLOATING" == "false" ]]; then
  if [[ -f "$STATE_MANAGED" ]]; then
    PREVIOUS_MANAGED=$(cat "$STATE_MANAGED")
    if [[ -n "$PREVIOUS_MANAGED" && "$PREVIOUS_MANAGED" != "$CURRENT_ID" ]]; then
      yabai -m window "$PREVIOUS_MANAGED" --sub-layer auto >/dev/null 2>&1
    fi
  fi

  if [[ -f "$STATE_FLOAT" ]]; then
    LAST_FLOAT=$(cat "$STATE_FLOAT")
    if [[ -n "$LAST_FLOAT" ]]; then
      yabai -m window "$LAST_FLOAT" --sub-layer below >/dev/null 2>&1
    fi
  fi

  yabai -m query --windows | jq -r '.[] | select(."is-floating" == true) | .id' | while IFS= read -r FLOAT_ID; do
    [[ -n "$FLOAT_ID" ]] || continue
    yabai -m window "$FLOAT_ID" --sub-layer below >/dev/null 2>&1
  done

  yabai -m window "$CURRENT_ID" --raise >/dev/null 2>&1
  echo "$CURRENT_ID" > "$STATE_MANAGED"
else
  if [[ -f "$STATE_FLOAT" ]]; then
    PREVIOUS_FLOAT=$(cat "$STATE_FLOAT")
    if [[ -n "$PREVIOUS_FLOAT" && "$PREVIOUS_FLOAT" != "$CURRENT_ID" ]]; then
      yabai -m window "$PREVIOUS_FLOAT" --sub-layer below >/dev/null 2>&1
    fi
  fi

  yabai -m window "$CURRENT_ID" --sub-layer above >/dev/null 2>&1

  if [[ "$PID" != "null" && -n "$PID" ]]; then
    /usr/bin/osascript -e "tell application \"System Events\" to set frontmost of process (id $PID) to true" >/dev/null 2>&1
  fi

  echo "$CURRENT_ID" > "$STATE_FLOAT"
fi

