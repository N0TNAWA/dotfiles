#!/bin/bash

# Variables
WALLPAPER_DIR="$HOME/Wallpapers"
SDDM_WALLPAPER_DIR="/usr/share/sddm/themes/sugar-candy/Backgrounds"
CACHE_DIR="$HOME/.cache/mineral"
THUMBNAIL_DIR="$CACHE_DIR/wallpaper_thumbnails"

# Ensure thumbnail directory exists
mkdir -p "$THUMBNAIL_DIR"

# --- Sync thumbnail cache ---
# Loop through all wallpapers and create missing thumbnails
for wallpaper in "$WALLPAPER_DIR"/*; do
    name=$(basename "$wallpaper")
    thumb="$THUMBNAIL_DIR/${name%.*}.png"

    if [[ ! -f "$thumb" ]]; then
        magick "$wallpaper" -resize 512x512 "$thumb"
    fi
done

# --- If no arguments are passed, just list wallpapers with thumbnails ---
if [ -z "$1" ]; then
    for wallpaper in "$WALLPAPER_DIR"/*; do
        name=$(basename "$wallpaper")
        thumb="$THUMBNAIL_DIR/${name%.*}.png"
        echo -en "$name\0icon\x1f$thumb\n"
    done
    exit 0
fi

# --- If wallpaper is selected, apply it ---
SELECTED="$1"
WALLPAPER="$WALLPAPER_DIR/$SELECTED"

# Defensive: Check if it actually exists
[ ! -f "$WALLPAPER" ] && notify-send "Wallpaper not found" && exit 1

notify-send --icon=$WALLPAPER "Changed wallpaper" "Changed wallpaper to $WALLPAPER"

swww img "$WALLPAPER" --transition-step 80 --transition-fps 80 --transition-type any --transition-duration 1
sleep 1

wal --cols16 -i "$WALLPAPER" \
&& ~/.config/hypr/scripts/update_dunst_colors.sh \
&& pywal-spicetify text \
&& walcord -i "$WALLPAPER" -t ~/.config/vesktop/themes/midnight.template.css -o ~/.config/vesktop/themes/midnight.theme.css \
&& ~/.config/hypr/scripts/qml_colors.sh

(sleep 0.1 && pkill rofi) &

# Update current wallpaper in cache
cp "$WALLPAPER" "$CACHE_DIR/wallpaper.png"

# Copy to SDDM theme
cp "$CACHE_DIR/wallpaper.png" "$SDDM_WALLPAPER_DIR"

# Remove this line to preserve thumbnail cache!
# rm -rf "$THUMBNAIL_DIR"

# Reload Waybar
killall waybar && exec waybar
