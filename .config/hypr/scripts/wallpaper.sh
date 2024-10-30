WALLPAPER_DIR="$HOME/Wallpapers"
WALLPAPER_SAVE_PATH="$HOME/.config/hypr/current_wallpaper"
THUMBNAIL_DIR="$HOME/.cache/wallpaper_thumbnails"

mkdir -p "$THUMBNAIL_DIR"

for wallpaper in "$WALLPAPER_DIR"/*; do
	thumbnail="$THUMBNAIL_DIR/$(basename "$wallpaper").png"
	if [ ! -f "$thumbnail" ]; then
        	convert "$wallpaper" -resize 512x512 "$thumbnail"
	fi
done

entries=""
for wallpaper in "$WALLPAPER_DIR"/*; do
	name=$(basename "$wallpaper")
	icon="$THUMBNAIL_DIR/$name.png"
	entries+="$name\0icon\x1f$icon\n"
done

WALLPAPER=$(echo -e "$entries" | rofi -dmenu -i -p "Choose Wallpaper" -theme $HOME/.config/rofi/styles/swww.rasi -markup-rows)

[ -z "$WALLPAPER"] && exit 1

swww img "$WALLPAPER_DIR/$WALLPAPER" && wal -i "$WALLPAPER_DIR/$WALLPAPER" && ~/.config/hypr/scripts/update-dunst-colors.sh

echo "$WALLPAPER_DIR/$WALLPAPER" > "WALLPAPER_SAVE_PATH"

killall waybar
exec waybar
