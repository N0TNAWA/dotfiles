#!/bin/bash

# Function to check for and display Pacman package updates
function check_pacman_updates {
    pacman_updates=$( (while pgrep -x checkupdates > /dev/null ; do sleep 1; done) ; checkupdates | wc -l)
    echo "󰮯  $pacman_updates"
}

# Function to perform Pacman updates
function update_pacman {
    if (( pacman_updates > 0 )); then
        read -p "Do you want to update $pacman_updates Pacman packages? (y/n): " choice
        if [[ "$choice" =~ ^[Yy]$ ]]; then
            sudo pacman -Syu --noconfirm
        else
            echo "Skipping Pacman updates."
        fi
    else
        echo "No Pacman packages to update."
    fi
}

# Function to check for and display Flatpak updates
function check_flatpak_updates {
    if command -v flatpak &> /dev/null; then
        flatpak_updates=$(flatpak remote-ls --updates 2> /dev/null | wc -l)
        echo "󰏔  $flatpak_updates"
    else
        flatpak_updates=0
        echo "Flatpak is not installed, skipping Flatpak check."
    fi
}

# Function to perform Flatpak updates
function update_flatpak {
    if (( flatpak_updates > 0 )); then
        read -p "Do you want to update $flatpak_updates Flatpak apps? (y/n): " choice
        if [[ "$choice" =~ ^[Yy]$ ]]; then
            flatpak update -y
        else
            echo "Skipping Flatpak updates."
        fi
    else
        echo "No Flatpak apps to update."
    fi
}

# Function to check for and display AUR updates
function check_aur_updates {
    if command -v paru &> /dev/null; then
        aur_updates=$(paru -Qu --aur 2> /dev/null | wc -l)
        echo "󰣇  $aur_updates"
    elif command -v yay &> /dev/null; then
        aur_updates=$(yay -Qu --aur 2> /dev/null | wc -l)
        echo "󰣇  $aur_updates"
    else
        aur_updates=0
        echo "AUR helper not installed. Install paru or yay to enable AUR updates."
    fi
}

# Function to perform AUR updates
function update_aur {
    if (( aur_updates > 0 )); then
        read -p "Do you want to update $aur_updates AUR packages? (y/n): " choice
        if [[ "$choice" =~ ^[Yy]$ ]]; then
            if command -v paru &> /dev/null; then
                paru -Syu --noconfirm
            elif command -v yay &> /dev/null; then
                yay -Syu --noconfirm
            fi
        else
            echo "Skipping AUR updates."
        fi
    else
        echo "No AUR packages to update."
    fi
}

# Function to clear cached packages
function clear_cache {
    echo "Clearing unnecessary cached packages..."
    sudo pacman -Sc --noconfirm
}

# Function to remove orphaned packages
function remove_orphans {
    echo "Checking for orphaned packages..."
    orphans=$(pacman -Qdtq)
    if [[ -n $orphans ]]; then
        echo "Removing orphaned packages..."
        sudo pacman -Rns --noconfirm $orphans
    else
        echo "No orphaned packages found."
    fi
}

# Run checks for updates and prompt the user
check_pacman_updates
check_flatpak_updates
check_aur_updates

# Run updates based on user confirmation
update_pacman
update_flatpak
update_aur
clear_cache
remove_orphans

echo "System update complete!"

# Prompt to reboot
read -p "Do you want to reboot now? (y/n): " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
    echo "Rebooting..."
    sudo reboot
else
    echo "Update finished without reboot."
fi


