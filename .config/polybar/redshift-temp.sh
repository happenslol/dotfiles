#!/bin/bash

ICON=
if [[ "$(pgrep -x redshift)" ]]; then
    temp=$(redshift -p 2> /dev/null | grep temp | cut -d ":" -f 2 | tr -dc "[:digit:]")
    short=$(echo "$temp / 1000" | bc -l)
    withk=$(printf "%.1fk" $short)

    if [[ -z "$temp" ]]; then
        echo "$withk%{T3}%{F#65737E}  $ICON%{F-}"
    elif [[ "$temp" -ge 5000 ]]; then
        echo "$withk%{T3}%{F#8FA1B3}  $ICON%{F-}"
    elif [[ "$temp" -ge 4000 ]]; then
        echo "$withk%{T3}%{F#EBCB8B}  $ICON%{F-}"
    else
        echo "$withk%{T3}%{F#D08770}  $ICON%{F-}"
    fi
fi
