#!/bin/bash

# Variables
WALLPAPER_DIR="$HOME/Wallpapers"
SDDM_WALLPAPER_DIR="/usr/share/sddm/themes/sugar-candy/Backgrounds"
CACHE_DIR="$HOME/.cache/mineral"
THUMBNAIL_DIR="$CACHE_DIR/wallpaper_thumbnails"

# Ensure thumbnail directory exists
mkdir -p "$THUMBNAIL_DIR"

# If no arguments are passed, list wallpapers
if [ -z "$1" ]; then
    # Generate thumbnails if they don't exist
    for wallpaper in "$WALLPAPER_DIR"/*; do
        name=$(basename "$wallpaper")
        ext="${name##*.}"
        thumb="$THUMBNAIL_DIR/${name%.*}.png"

        if [ ! -f "$thumb" ]; then
            magick "$wallpaper" -resize 512x512 "$thumb"
        fi

        echo -en "$name\0icon\x1f$thumb\n"
    done
    exit 0
fi

# If wallpaper selected, apply changes
SELECTED="$1"
WALLPAPER="$WALLPAPER_DIR/$SELECTED"

# Defensive: Check if it actually exists
[ ! -f "$WALLPAPER" ] && notify-send "Wallpaper not found" && exit 1

# Apply wallpaper, Pywal, etc.
swww img "$WALLPAPER" \
    && wal -i "$WALLPAPER" \
    && ~/dotfiles/.config/hypr/scripts/update_dunst_colors.sh \
    && pywal-spicetify text \
    && themecord -p

# Update current wallpaper in cache
cp "$WALLPAPER" "$CACHE_DIR/wallpaper.png"

# Copy to SDDM theme
cp "$CACHE_DIR/wallpaper.png" "$SDDM_WALLPAPER_DIR"

# Clean thumbnails (optional – or comment out for caching)
rm -rf "$THUMBNAIL_DIR"

# Reload Waybar
killall waybar && exec waybar
