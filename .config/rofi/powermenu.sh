#!/bin/bash
LOGOUT=
POWEROFF=
RESTART=

RESULT=$(echo -e "$POWEROFF\n$RESTART\n$LOGOUT" | rofi -dmenu -config $HOME/.config/rofi/powermenu.rasi)

case $RESULT in
  $LOGOUT )
    i3-msg exit;;
  $POWEROFF )
    poweroff;;
  $RESTART )
    reboot;;
esac