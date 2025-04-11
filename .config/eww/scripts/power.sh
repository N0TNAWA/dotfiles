#!/bin/bash

power_off() {
  systemctl poweroff
}

reboot() {
  systemctl reboot
}

log_out() {
  hyprctl dispatch exit 0
}

hibernate() {
  systemctl hibernate
}

if [[ "$1" == "--p" ]]; then
  power_off
elif [[ "$1" == "--r" ]]; then
  reboot
elif [[ "$1" == "--l" ]]; then
  log_out
elif [[ "$1" == "--h" ]]; then
  hibernate
fi
