#!/bin/bash

EWW=`which eww`
CFG="$HOME/.config/eww"

## Run eww daemon if not running already
if [[ ! `pidof eww` ]]; then
	${EWW} daemon
	sleep 1
fi

## Open widgets 
run_eww() {
	${EWW} --config "$CFG" open-many \
		   profile \
		   calendar_full \
		   weather_now \
		   spotify \
		   power
}

## Launch or close widgets accordingly
run_eww
