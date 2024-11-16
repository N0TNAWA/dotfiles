# Variables
WALLPAPER_DIR="$HOME/Wallpapers"
SDDM_WALLPAPER_DIR="/usr/share/sddm/themes/sugar-candy/Backgrounds"
CACHE_DIR="$HOME/.cache/mineral"
THUMBNAIL_DIR="$HOME/.cache/mineral/wallpaper_thumbnails"

# If there is no thumbnail directory. Create one
mkdir -p "$CACHE_DIR"
mkdir -p "$THUMBNAIL_DIR"

# Making thumbnail
for wallpaper in "$WALLPAPER_DIR"/*; do
	thumbnail="$THUMBNAIL_DIR/$(basename "$wallpaper").png"
	if [ ! -f "$thumbnail" ]; then
        	magick "$wallpaper" -resize 512x512 "$thumbnail"
	fi
done

# Set wallpaper
entries=""
for wallpaper in "$WALLPAPER_DIR"/*; do
	name=$(basename "$wallpaper")
	icon="$THUMBNAIL_DIR/$name.png"
	entries+="$name\0icon\x1f$icon\n"
done

WALLPAPER=$(echo -e "$entries" | rofi -dmenu -i -theme "$HOME/dotfiles/.config/rofi/styles/swww.rasi" -markup-rows)

[ -z "$WALLPAPER"] && exit 1

swww img "$WALLPAPER_DIR/$WALLPAPER" && wal -i "$WALLPAPER_DIR/$WALLPAPER" && ~/dotfiles/.config/hypr/scripts/update_dunst_colors.sh

# Put current wallpaper in a asset directory
cp "$WALLPAPER_DIR/$WALLPAPER" "$CACHE_DIR"

file_to_rename="$CACHE_DIR/$WALLPAPER"

new_image="wallpaper.png"

if [[ -n "$file_to_rename" ]]; then
    mv "$file_to_rename" "$CACHE_DIR/$new_image"
else
    echo "No image file found"
fi

# Change SDDM wallpaper
cp "$CACHE_DIR/$new_image" "$SDDM_WALLPAPER_DIR"

# Refresh the thumbnail directory
rm -r "$THUMBNAIL_DIR"

# Reload waybar
killall waybar
exec waybar
