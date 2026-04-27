#!/usr/bin/env bash

# Options
shutdown="Shutdown"
reboot="Reboot"
lock="Lock"
suspend="Suspend"
logout="Logout"

# Prompt
chosen=$(echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi -dmenu -p "Power" -config -theme ~/.config/rofi/powermenu.rasi)

case "$chosen" in
    "$shutdown")
        systemctl poweroff
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$lock")
        hyprlock
        ;;
    "$suspend")
        systemctl suspend
        ;;
    "$logout")
        hyprctl dispatch exit
        ;;
esac
