#!/bin/bash
pamixer --default-source -t

if pamixer --default-source --get-mute; then
    dunstify -a mic \
        -h string:x-dunst-stack-tag:mic \
        -i microphone-sensitivity-muted \
        -u low "Microphone" "Muted"
else
    vol=$(pamixer --default-source --get-volume)
    dunstify -a mic \
        -h string:x-dunst-stack-tag:mic \
        -h int:value:"$vol" \
        -i microphone-sensitivity-high \
        -u low "Microphone" "${vol}%"
fi

