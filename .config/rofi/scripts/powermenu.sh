#!/usr/bin/env bash

# Options
shutdown="Shutdown"
reboot="Reboot"
lock="Lock"
logout="Logout"

# Prompt
chosen=$(echo -e "$lock\n$logout\n$reboot\n$shutdown" | rofi -dmenu -p "Power" -config -theme ~/.config/rofi/powermenu.rasi)

case "$chosen" in
    "$shutdown")
        shutdown -h now
        ;;
    "$reboot")
        reboot
        ;;
    "$lock")
        hyprlock
        ;;
    "$logout")
        hyprctl dispatch exit
        ;;
esac
