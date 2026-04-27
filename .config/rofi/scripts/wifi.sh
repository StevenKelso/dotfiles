#!/usr/bin/env bash

dunstify "WiFi Manager" "Getting list of available WiFi networks"

# Scan and list available networks
networks=$(nmcli -f SSID,SIGNAL,SECURITY device wifi list | tail -n +2 | awk '{printf "%-30s %s%%  %s\n", $1, $2, $3}')

chosen=$(echo "$networks" | rofi -dmenu -p "WiFi" -config -theme ~/.config/rofi/wifi.rasi | awk '{print $1}')

[[ -z "$chosen" ]] && exit

# Connect (prompts for password if needed via a second rofi)
if nmcli -f NAME connection show | grep -q "^$chosen"; then
    nmcli connection up "$chosen"
else
    password=$(rofi -dmenu -p "Password for $chosen" -config ~/.config/rofi/config.rasi -password)
    nmcli device wifi connect "$chosen" password "$password"
fi
