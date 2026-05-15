#!/bin/bash

# Decrease mic volume by 5%
wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-

vol=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print int($2 * 100)}')

notify-send \
    -a mic \
    -h string:x-canonical-private-synchronous:mic \
    -h int:value:"$vol" \
    -i microphone-sensitivity-high \
    -u low \
    "Microphone" "${vol}%"
