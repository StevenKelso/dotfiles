#!/bin/bash
pamixer --default-source -d 5
vol=$(pamixer --default-source --get-volume)

dunstify -a mic \
    -h string:x-dunst-stack-tag:mic \
    -h int:value:"$vol" \
    -i microphone-sensitivity-low \
    -u low "Microphone" "${vol}%"

