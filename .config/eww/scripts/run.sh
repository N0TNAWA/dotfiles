#!/bin/bash


EWW=$(which eww)
CFG="$HOME/.config/eww"
LOG="$HOME/eww-toggle.log"
WIDGETS=(profile calendar_full weather_now spotify power)


DAEMON_WAIT=0.2  
OPEN_WAIT=0.1    

echo "----- $(date) -----" >> "$LOG"

are_widgets_open() {
    local opened_windows
    opened_windows=$("$EWW" --config "$CFG" list-windows 2>/dev/null)

    if echo "$opened_windows" | grep -qE "$(IFS="|"; echo "${WIDGETS[*]}")"; then
        return 0
    else
        return 1
    fi
}


check_daemon() {
    if ! pgrep -x eww > /dev/null; then
        "$EWW" daemon --config "$CFG" >> "$LOG" 2>&1 &
        sleep $DAEMON_WAIT 
        return 1  
    fi
    return 0
}


if are_widgets_open; then    
    pkill -x eww
else
    daemon_was_running=1
    check_daemon || daemon_was_running=0
    
    [ $daemon_was_running -eq 0 ] && sleep $OPEN_WAIT
    
    "$EWW" --config "$CFG" open-many "${WIDGETS[@]}" >> "$LOG" 2>&1 &
fi
