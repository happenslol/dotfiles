#!/bin/bash
STAMP=$(date +"%FT%T")
MILLIS=$((`date +"%N"` / 1000))

FILENAME="$STAMP.$MILLIS"

case $1 in
  "window" )
    maim -i $(xdotool getactivewindow) | \
      xclip -selection clipboard -t image/png && \
      xclip -selection clipboard -o > ${HOME}/screenshots/${FILENAME}.png;;
  "select" )
    maim -s | \
      xclip -selection clipboard -t image/png && \
      xclip -selection clipboard -o > ${HOME}/screenshots/${FILENAME}.png;;
  "all" )
    maim | \
      xclip -selection clipboard -t image/png && \
      xclip -selection clipboard -o > ${HOME}/screenshots/${FILENAME}.png;;
esac
