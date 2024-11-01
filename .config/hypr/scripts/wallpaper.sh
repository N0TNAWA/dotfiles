# Variables
WALLPAPER_DIR="$HOME/Wallpapers"
WALLPAPER_SAVE_PATH="$HOME/dotfiles/.config/hypr/current_wallpaper"
THUMBNAIL_DIR="$HOME/.cache/wallpaper_thumbnails"
SDDM_WALLPAPER_DIR="/usr/share/sddm/themes/sugar-candy/Backgrounds"

# If there is no thumbnail directory. Create one
mkdir -p "$THUMBNAIL_DIR"

# Making thumbnail
for wallpaper in "$WALLPAPER_DIR"/*; do
	thumbnail="$THUMBNAIL_DIR/$(basename "$wallpaper").png"
	if [ ! -f "$thumbnail" ]; then
        	convert "$wallpaper" -resize 512x512 "$thumbnail"
	fi
done

# Set wallpaper
entries=""
for wallpaper in "$WALLPAPER_DIR"/*; do
	name=$(basename "$wallpaper")
	icon="$THUMBNAIL_DIR/$name.png"
	entries+="$name\0icon\x1f$icon\n"
done

WALLPAPER=$(echo -e "$entries" | rofi -dmenu -i -p "Choose Wallpaper" -theme $HOME/.config/rofi/styles/swww.rasi -markup-rows)

[ -z "$WALLPAPER"] && exit 1

swww img "$WALLPAPER_DIR/$WALLPAPER" && wal -i "$WALLPAPER_DIR/$WALLPAPER" && ~/dotfiles/.config/hypr/scripts/update-dunst-colors.sh

# Save wallpaper
echo "$WALLPAPER_DIR/$WALLPAPER" > "WALLPAPER_SAVE_PATH"

# Change SDDM Wallpaper
cp "$WALLPAPER_DIR/$WALLPAPER" "$SDDM_WALLPAPER_DIR"
new_name="wallpaper.png"

file_to_rename=$(find "$SDDM_WALLPAPER_DIR" -type f \( -name "*.png" \) | head -n 1)

if [[ -n "$file_to_rename" ]]; then
    mv "$file_to_rename" "$SDDM_WALLPAPER_DIR/$new_name"
else
    echo "No image file found in $folder_path"
fi

# Refresh the thumbnail directory
rm -r "$THUMBNAIL_DIR"

# Reload waybar
killall waybar
exec waybar
