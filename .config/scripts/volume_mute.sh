#!/bin/bash

# Toggle mute for default sink
wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

# Check if muted
if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED; then
    notify-send \
        -a volume \
        -h string:x-canonical-private-synchronous:volume \
        -i audio-volume-muted \
        -u low \
        "Volume" "Muted"
else
    vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')

    notify-send \
        -a volume \
        -h string:x-canonical-private-synchronous:volume \
        -h int:value:"$vol" \
        -i audio-volume-high \
        -u low \
        "Volume" "${vol}%"
fi
