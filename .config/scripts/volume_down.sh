#!/bin/bash
pamixer -d 5
vol=$(pamixer --get-volume)

# using dunstify (recommended) or notify-send
dunstify -a volume \
    -h string:x-dunst-stack-tag:volume \
    -h int:value:"$vol" \
    -i audio-volume-high \
    -u low "Volume" "${vol}%"
