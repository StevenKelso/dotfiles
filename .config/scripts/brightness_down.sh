#!/bin/bash
brightnessctl set 5%- -q
brightness=$(brightnessctl get)
max=$(brightnessctl max)
percent=$(( 100 * brightness / max ))

dunstify -a brightness \
    -h string:x-dunst-stack-tag:brightness \
    -h int:value:"$percent" \
    -i display-brightness-low \
    -u low "Brightness" "${percent}%"

