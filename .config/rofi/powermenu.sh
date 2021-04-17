#!/bin/bash
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme $HOME/.config/rofi/powermenu"

# Options
shutdown=""
reboot=""
lock=""
suspend=""
logout=""

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
    systemctl poweroff
    ;;
    $reboot)
    systemctl reboot
    ;;
    $lock)
    ;;
    $suspend)
    mpc -q pause
    amixer set Master mute
    systemctl suspend
    ;;
    $logout)
    i3-msg exit
    ;;
esac
