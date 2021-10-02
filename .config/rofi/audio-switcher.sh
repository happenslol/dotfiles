#!/bin/bash
sinks_raw=$(pactl list sinks | rg -e "Name: " -e "device.description = ")
mapfile -t sinks < <(echo "$sinks_raw")
rofi_command="rofi -theme $HOME/.config/rofi/audio-switcher"

sink_names=()
sink_ids=()
active_sink=-1
default_sink=$(pactl get-default-sink)

for ((i=0; i < ${#sinks[@]}; i+=2)); do
  sink_parts=("${sinks[@]:i:2}")
  sink_id=$(echo "${sink_parts[0]}" | rg -oP "Name:\s\K.*\$")
  sink_name=$(echo "${sink_parts[1]}" | rg -o '".*"' | sed 's/"//g')

  sink_names[${#sink_names[@]}]="${sink_name}"
  sink_ids[${#sink_ids[@]}]="${sink_id}"
  [[ "$sink_id" == "$default_sink" ]] && active_sink="$(expr $i / 2)"
done

options=$(printf "%s\n" "${sink_names[@]}")
chosen_index="$(echo -e "$options" | $rofi_command -a ${active_sink} -dmenu -format "i")"

if [[ -v sink_ids[$chosen_index] ]]; then
  chosen="${sink_ids[$chosen_index]}"
  pactl set-default-sink "$chosen"

  pactl list short sink-inputs | while read s; do
    sid=$(echo $s | cut '-d ' -f1)
    pactl move-sink-input "$sid" "$chosen"
  done
fi
