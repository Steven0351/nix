#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

PADDING=""
if [[ $NAME == "space.1" ]]; then
  PADDING="icon.padding_left=14"
elif [[ $NAME == "space.9" ]]; then
  PADDING="icon.padding_right=14"
else
  PADDING=""
fi

if [ "$SELECTED" = "true" ]; then
  sketchybar --set $NAME background.drawing=on \
                   background.color=0x00 \
                   background.corner_radius=0 \
                   background.height=24 \
                   $PADDING \
                   icon.color=$WAVE_RED \
                   icon.font="TX02 Nerd Font:Black:15.0"
else
  sketchybar --set $NAME background.drawing=on \
                   background.color=0x00 \
                   background.corner_radius=0 \
                   background.height=24 \
                   $PADDING \
                   icon.color=$FUJI_WHITE \
                   icon.font="TX02 Nerd Font:Semibold:15.0"
fi
