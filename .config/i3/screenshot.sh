#!/bin/bash
STAMP=$(date +"%FT%T")
MILLIS=$((`date +"%N"` / 1000))

FILENAME="$STAMP.$MILLIS"

case $1 in
  "window" )
    maim -i $(xdotool getactivewindow) | \
      xclip -selection clipboard -t image/png && \
      xclip -selection clipboard -o > ${HOME}/screenshots/${FILENAME}.png
      
    dunstify -a "screenshot" "Window Screenshot taken" "Saved as ${FILENAME}.png"
      ;;
  "select" )
    maim -s | \
      xclip -selection clipboard -t image/png && \
      xclip -selection clipboard -o > ${HOME}/screenshots/${FILENAME}.png

    dunstify -a "screenshot" "Selection Screenshot taken" "Saved as ${FILENAME}.png"
    ;;
  "all" )
    maim | \
      xclip -selection clipboard -t image/png && \
      xclip -selection clipboard -o > ${HOME}/screenshots/${FILENAME}.png

    dunstify -a "screenshot" "Full Screenshot taken" "Saved as ${FILENAME}.png"
    ;;
esac
