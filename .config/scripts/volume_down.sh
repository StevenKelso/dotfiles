#!/bin/bash

# Decrease volume by 5%
wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-

# Get the current volume as a percentage
vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')

# Send desktop notification
notify-send \
    -a volume \
    -h string:x-canonical-private-synchronous:volume \
    -h int:value:"$vol" \
    -i audio-volume-low \
    -u low \
    "Volume" "${vol}%"
