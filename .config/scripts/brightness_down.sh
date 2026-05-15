#!/bin/bash

brightnessctl set 5%- -q

brightness=$(brightnessctl get)
max=$(brightnessctl max)
percent=$(( 100 * brightness / max ))

notify-send \
    -a brightness \
    -h string:x-canonical-private-synchronous:brightness \
    -h int:value:"$percent" \
    -i display-brightness-low \
    -u low \
    "Brightness" "${percent}%"
