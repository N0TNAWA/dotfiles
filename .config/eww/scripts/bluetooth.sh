#!/usr/bin/env bash

mac=$(bluetoothctl devices | awk '/^Device/ {print $2}')

if [[ $1 == "--device" ]]; then
  device=$(bluetoothctl devices | awk '/^Device/ { $1=""; $2=""; sub(/^  */, ""); print }')

  echo "$device"
elif [[ $1 == "--battery" ]]; then
  battery=$(bluetoothctl info $mac | awk '/Battery Percentage/ {gsub(/[()]/, "", $NF); print $NF}')

  echo "$battery"
elif [[ $1 == "--icon" ]]; then
  icon=$(bluetoothctl info $mac | awk '/Icon/ { $1=""; sub(/^ */, ""); print }')
  if [[ "$icon" == "input-gaming" ]]; then
    echo "󰮂"
  elif [[ "$icon" == "audio-headset" ]]; then
    echo ""
  elif [[ "$icon" == "audio-headphones" ]]; then
    echo "󱡏"
  else
    echo "?"
  fi
elif [[ $1 == "--mac" ]]; then
  echo "$mac"

elif [[ $1 == "--dc" ]]; then
  bluetoothctl disconnect $mac
fi
exit
  
