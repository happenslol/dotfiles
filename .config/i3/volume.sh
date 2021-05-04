#!/bin/bash
# changeVolume

case $1 in
  "up" )
    pactl set-sink-volume @DEFAULT_SINK@ +5% >> /dev/null
    ;;
  "down" )
    pactl set-sink-volume @DEFAULT_SINK@ -5% >> /dev/null
    ;;
  "toggle" )
    pactl set-sink-mute @DEFAULT_SINK@ toggle >> /dev/null
    ;;
esac
