#!/bin/bash
# changeVolume

case $1 in
  "up" )
    amixer -D pulse sset Master "5%+" > /dev/null;;
  "down" )
    amixer -D pulse sset Master "5%-" > /dev/null;;
  "toggle" )
    amixer -D pulse sset Master toggle > /dev/null;;
esac
