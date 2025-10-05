#!/bin/bash

# Increase mic volume by 5%, allow up to 150%
wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SOURCE@ 5%+

vol=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print int($2 * 100)}')

dunstify -a mic \
    -h string:x-dunst-stack-tag:mic \
    -h int:value:"$vol" \
    -i microphone-sensitivity-high \
    -u low "Microphone" "${vol}%"
