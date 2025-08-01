#!/bin/bash

LOGFILE="/tmp/quickshell.log"

# Optional: timestamp
echo "=== Launched at $(date) ===" >> "$LOGFILE"

# Export any required environment vars here, if needed
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
export QML_XHR_ALLOW_FILE_READ=1

# Run quickshell and log its output

PROCESS="quickshell"

if pgrep -x "$PROCESS" > /dev/null; then
    echo "Quickshell is running. Stopping it..."
    pkill -x "$PROCESS"
else
    echo "Quickshell is not running. Starting it..."
    quickshell >> "$LOGFILE" 2>&1
fi
