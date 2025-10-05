#!/bin/bash

# Decrease volume by 5%
wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-

vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')

dunstify -a volume \
    -h string:x-dunst-stack-tag:volume \
    -h int:value:"$vol" \
    -i audio-volume-low \
    -u low "Volume" "${vol}%"
