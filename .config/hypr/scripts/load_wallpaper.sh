WALLPAPER_SAVE_PATH="$HOME/.config/hypr/current_wallpaper"

if [ -f "$WALLPAPER_SAVE_PATH" ]; then
    WALLPAPER=$(cat "$WALLPAPER_SAVE_PATH")
    swww img "$WALLPAPER" && wal -i "$WALLPAPER"
fi
