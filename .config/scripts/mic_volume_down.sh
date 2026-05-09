#!/bin/bash

# Decrease mic volume by 5%
wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-

vol=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print int($2 * 100)}')

dunstify -a mic \
    -h string:x-dunst-stack-tag:mic \
    -h int:value:"$vol" \
    -i microphone-sensitivity-low \
    -u low "Microphone" "${vol}%"

