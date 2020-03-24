#!/bin/bash
# changeVolume

# Arbitrary but unique message id
msgId="99991"

case $1 in
  "up" )
    brightnessctl s 5%+ > /dev/null;;
  "down" )
    brightnessctl s 5%- > /dev/null;;
esac

max=$(brightnessctl m)
current=$(brightnessctl g)
percent=$(echo "($current / $max) * 100" | bc -l | rg -o "^[0-9]+")

on_color="#ffcb6b"
dunstify -a "changeBrightness" -u low -r "$msgId" \
  "" "$($HOME/.config/dunst/get-progress-string.sh 20 "<span foreground='$on_color'>-</span>" "-" $percent)"