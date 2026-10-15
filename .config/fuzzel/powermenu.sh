#!/bin/bash

choice=$(printf "lock\nlogout\nreboot\nshutdown" | fuzzel --dmenu --prompt "Power: ")

case "$choice" in
    lock)
        hyprlock
        ;;
    logout)
        command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'
        ;;
    reboot)
        systemctl reboot
        ;;
    shutdown)
        systemctl poweroff
        ;;
esac
