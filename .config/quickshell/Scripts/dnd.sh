#!/usr/bin/env bash

CONF_DIR="$HOME/.config/system_prefs"
CONF_FILE="$CONF_DIR/syspref.conf"

mkdir -p "$CONF_DIR"

if [ ! -e "$CONF_FILE" ]; then
    touch "$CONF_FILE"
fi


toggle_dnd() {
    if grep -q "DND_ON=false" "$CONF_FILE"; then
        sed -i 's/DND_ON=false/DND_ON=true/' "$CONF_FILE"

        notify-send "Changed do not disturb." "Do not disturb is now set to true"

        sleep 5

        systemctl --user stop dunst.service
        systemctl --user mask dunst.service

    else
        sed -i 's/DND_ON=true/DND_ON=false/' "$CONF_FILE"
        
        systemctl --user unmask dunst.service

        notify-send "Changed do not disturb." "Do not disturb is now set to false"
    fi
}

check_dnd() {
    grep "DND_ON" "$CONF_FILE" | cut -d'=' -f2
}



if ! grep -q "DND_ON" "$CONF_FILE"; then
    echo "Setting not found, adding..."
    echo "DND_ON=false" >> "$CONF_FILE"
fi

if [[ "$1" = "-c" || "$1" = "--check" ]]; then
    check_dnd $1
  elif [[ "$1" = "-t" || "$1" = "--toggle" ]]; then
    toggle_dnd $1
fi






