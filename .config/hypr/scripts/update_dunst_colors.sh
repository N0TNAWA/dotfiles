#!/bin/bash

# Load Pywal colors
source ~/.cache/wal/colors.sh

# Define the Dunst config path
DUNST_CONFIG=~/.config/dunst/dunstrc

# Update Dunst colors in the configuration file
sed -i "s/background = .*/background = \"${color0}\"/g" "$DUNST_CONFIG"
sed -i "s/foreground = .*/foreground = \"${color7}\"/g" "$DUNST_CONFIG"
sed -i "s/frame_color = .*/frame_color = \"${color2}\"/g" "$DUNST_CONFIG"

# Low urgency
sed -i "s/urgency_low.background = .*/urgency_low.background = \"${color0}\"/g" "$DUNST_CONFIG"
sed -i "s/urgency_low.foreground = .*/urgency_low.foreground = \"${color5}\"/g" "$DUNST_CONFIG"
sed -i "s/urgency_low.frame_color = .*/urgency_low.frame_color = \"${color2}\"/g" "$DUNST_CONFIG"

# Normal urgency
sed -i "s/urgency_normal.background = .*/urgency_normal.background = \"${color0}\"/g" "$DUNST_CONFIG"
sed -i "s/urgency_normal.foreground = .*/urgency_normal.foreground = \"${color7}\"/g" "$DUNST_CONFIG"
sed -i "s/urgency_normal.frame_color = .*/urgency_normal.frame_color = \"${color4}\"/g" "$DUNST_CONFIG"

# Critical urgency
sed -i "s/urgency_critical.background = .*/urgency_critical.background = \"${color0}\"/g" "$DUNST_CONFIG"
sed -i "s/urgency_critical.foreground = .*/urgency_critical.foreground = \"${color1}\"/g" "$DUNST_CONFIG"
sed -i "s/urgency_critical.frame_color = .*/urgency_critical.frame_color = \"${color1}\"/g" "$DUNST_CONFIG"

# Reload Dunst
killall dunst && dunst &
