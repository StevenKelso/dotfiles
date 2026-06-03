#!/usr/bin/env bash

# Options
shutdown="Shutdown"
reboot="Reboot"
lock="Lock"
logout="Logout"

# Fetch username
user=$(whoami)

# Fetch system uptime formatted cleanly
uptime_info=$(uptime -p | sed -e 's/up //')

# Prompt
chosen=$(echo -e "$lock\n$logout\n$reboot\n$shutdown" | rofi -p "$user" -mesg "Uptime: $uptime_info" -dmenu -selected-row 0 -theme ~/.config/rofi/powermenu.rasi)

case "$chosen" in
    "$shutdown")
        shutdown -h now
        ;;
    "$reboot")
        reboot
        ;;
    "$lock")
        swaylock
        ;;
    "$logout")
        niri msg action quit
        ;;
esac
