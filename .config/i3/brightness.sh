#!/bin/bash
# changeVolume

case $1 in
  "up" )
    brightnessctl s 5%+ > /dev/null;;
  "down" )
    brightnessctl s 5%- > /dev/null;;
esac