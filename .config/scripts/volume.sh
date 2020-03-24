#!/bin/sh

function get_volume {
    amixer -D pulse get Master | rg '%' \
        | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_muted {
    amixer -D pulse get Master | rg '%' || rg -oE '[^ ]+$' | rg off > /dev/null
}

function notify {
    volume=`get_volume`
    muted=`is_muted`

    if [ $muted ]; then
        icon_name="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-muted.svg"
    elif [ "$volume" = "0" ]; then
        icon_name="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-off.svg"
    elif [ "$volume" -lt "30" ]; then
        icon_name="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-low.svg"
    elif [ "$volume" -lt "70" ]; then
        icon_name="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-medium.svg"
    else
        icon_name="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-high.svg"
    fi

    bar=$(seq -s "─" $(($volume/5)) | sed 's/[0-9]//g')
    $DIR/notify-send.sh "$volume""     ""$bar" -i "$icon_name" -t 2000 -h int:value:"$volume" -h string:synchronous:"$bar" --replace=9001
}
