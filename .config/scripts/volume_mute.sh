#!/bin/bash
pamixer -t

if pamixer --get-mute; then
    dunstify -a volume \
        -h string:x-dunst-stack-tag:volume \
        -i audio-volume-muted \
        -u low "Volume" "Muted"
else
    vol=$(pamixer --get-volume)
    dunstify -a volume \
        -h string:x-dunst-stack-tag:volume \
        -h int:value:"$vol" \
        -i audio-volume-high \
        -u low "Volume" "${vol}%"
fi
