#!/bin/bash

# Check for Pacman updates
pacman_updates=$(checkupdates 2> /dev/null | wc -l)

# Check for Flatpak updates
if command -v flatpak &> /dev/null; then
    flatpak_updates=$(flatpak remote-ls --updates 2> /dev/null | wc -l)
else
    flatpak_updates=0
fi

# Check for AUR updates
if command -v paru &> /dev/null; then
    aur_updates=$(paru -Qu --aur 2> /dev/null | wc -l)
elif command -v yay &> /dev/null; then
    aur_updates=$(yay -Qu --aur 2> /dev/null | wc -l)
else
    aur_updates=0
fi

# Calculate the total updates
total_updates=$((pacman_updates + flatpak_updates + aur_updates))

# Output in JSON format for Waybar
echo "{\"text\":\"$total_updates\", \"tooltip\":\"Updates\"}"
