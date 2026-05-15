#!/bin/bash

# Toggle mic mute
wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED; then
    notify-send \
        -a mic \
        -h string:x-canonical-private-synchronous:mic \
        -i microphone-sensitivity-muted \
        -u low \
        "Microphone" "Muted"
else
    vol=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print int($2 * 100)}')

    notify-send \
        -a mic \
        -h string:x-canonical-private-synchronous:mic \
        -h int:value:"$vol" \
        -i microphone-sensitivity-high \
        -u low \
        "Microphone" "${vol}%"
fi
