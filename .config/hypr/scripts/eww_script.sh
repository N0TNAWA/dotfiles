#!/bin/bash

# Check if 'eww' is running
if pgrep -x "eww" > /dev/null; then
    echo "Eww is running. Closing it..."
    pkill -x eww
else
    echo "Eww is not running. Launching it..."
    eww daemon &
fi
