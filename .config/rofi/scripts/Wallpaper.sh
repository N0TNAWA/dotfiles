#!/bin/bash
set -euo pipefail

# --- Vars ---
WALLPAPER_DIR="$HOME/Wallpapers"
SDDM_WALLPAPER_DIR="/usr/share/sddm/themes/sugar-candy/Backgrounds"
CACHE_DIR="$HOME/.cache/mineral"
THUMBNAIL_DIR="$CACHE_DIR/wallpaper_thumbnails"
STATE_FILE="$HOME/.config/theme/theme-state" 

mkdir -p "$THUMBNAIL_DIR"

# --- Build thumbnail cache (once per file) ---
for wallpaper in "$WALLPAPER_DIR"/*; do
  name=$(basename "$wallpaper")
  thumb="$THUMBNAIL_DIR/${name%.*}.png"
  [[ -f "$thumb" ]] || magick "$wallpaper" -resize 512x512 "$thumb"
done

# --- No args: list wallpapers for rofi ---
if [[ -z "${1-}" ]]; then
  for wallpaper in "$WALLPAPER_DIR"/*; do
    name=$(basename "$wallpaper")
    thumb="$THUMBNAIL_DIR/${name%.*}.png"
    echo -en "$name\0icon\x1f$thumb\n"
  done
  exit 0
fi

# --- Apply selection ---
SELECTED="$1"
WALLPAPER="$WALLPAPER_DIR/$SELECTED"
[[ -f "$WALLPAPER" ]] || { notify-send "Wallpaper not found"; exit 1; }

notify-send --icon="$WALLPAPER" "Changed wallpaper" "Changed to $WALLPAPER"
swww img "$WALLPAPER" --transition-step 80 --transition-fps 80 --transition-type any --transition-duration 1
sleep 1

# --- Determine light/dark ---
# shellcheck disable=SC1090
. "$STATE_FILE"

is_light=0
case "${LIGHT_MODE:-0}" in 1|true|TRUE|True) is_light=1 ;; esac

# build args once
args=(--cols16 -i "$WALLPAPER")
if [[ $is_light -eq 1 ]]; then
  args=(-l "${args[@]}")   # add -l when light
fi

wal "${args[@]}"

# --- Post-wal hooks (chain correctly) ---
~/.config/hypr/scripts/update_dunst_colors.sh &&
pywal-spicetify text &&
walcord -i "$WALLPAPER" \
  -t ~/.config/vesktop/themes/midnight.template.css \
  -o ~/.config/vesktop/themes/midnight.theme.css &&
~/.config/hypr/scripts/qml_colors.sh

(sleep 0.1 && pkill rofi) &

# --- Cache + SDDM ---
cp "$WALLPAPER" "$CACHE_DIR/wallpaper.png"
cp "$CACHE_DIR/wallpaper.png" "$SDDM_WALLPAPER_DIR"

# --- Reload Waybar ---
killall waybar || true
exec waybar
