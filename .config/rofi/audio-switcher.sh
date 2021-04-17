#!/bin/bash
sinks_raw=$(pacmd list-sinks | rg -e "index:" -e "device.description =")
mapfile -t sinks < <(echo "$sinks_raw")
rofi_command="rofi -theme $HOME/.config/rofi/audio-switcher"

sink_names=()
sink_indices=()
active_sink=-1

for ((i=0; i < ${#sinks[@]}; i+=2)); do
  sink_parts=("${sinks[@]:i:2}")
  sink_index=$(echo "${sink_parts[0]}" | rg -oP "index:\s\K\d+")
  sink_name=$(echo "${sink_parts[1]}" | rg -o '".*"' | sed 's/"//g')

  sink_names[${#sink_names[@]}]="${sink_name}"
  sink_indices[${#sink_indices[@]}]="${sink_index}"
  [[ $sink_parts[0] =~ "*" ]] && active_sink="$(expr $i / 2)"
done

options=$(printf "%s\n" "${sink_names[@]}")
chosen="$(echo -e "$options" | $rofi_command -a ${active_sink} -dmenu -format "i")"
[[ -v "sink_indices[$chosen]" ]] && pacmd set-default-sink ${sink_indices[$chosen]}
