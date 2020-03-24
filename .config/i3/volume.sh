#!/bin/bash
# changeVolume

# Arbitrary but unique message id
msgId="99990"

case $1 in
  "up" )
    amixer -D pulse sset Master "5%+" > /dev/null;;
  "down" )
    amixer -D pulse sset Master "5%-" > /dev/null;;
  "toggle" )
    amixer -D pulse sset Master toggle > /dev/null;;
esac

# Query amixer for the current volume and whether or not the speaker is muted
volume="$(amixer -D pulse get Master | tail -1 | rg "[0-9]+%" -o | rg "[0-9]+" -o)"
mute="$(amixer -D pulse get Master | tail -1 | rg "(\[on\]|\[off\])" -o | rg "(on|off)" -o)"

on_color="#546e7a"
if [[ "$mute" == "off" ]]; then
  case $1 in
    "up" | "down" )
      amixer -D pulse sset Master toggle > /dev/null; on_color="#89ddff";;
  esac

  # Show the sound muted notification
  dunstify -a "changeVolume" -u low -r "$msgId" \
    "" "$($HOME/.config/dunst/get-progress-string.sh 20 "<span foreground='$on_color'>-</span>" "-" $volume)"
else
  on_color="#89ddff"
  # Show the volume notification
  dunstify -a "changeVolume" -u low -r "$msgId" \
    "" "$($HOME/.config/dunst/get-progress-string.sh 20 "<span foreground='$on_color'>-</span>" "-" $volume)"
fi

# Play the volume changed sound
# canberra-gtk-play -i audio-volume-change -d "changeVolume"