entries="  Change Wallpaper\n  Screen Copy\n  Clipboard History"

APP=$(echo -e "$entries" | rofi -dmenu -i -theme "$HOME/dotfiles/.config/rofi/styles/menu.rasi")

case "$APP" in
	"  Change Wallpaper")
		pkill rofi
		sleep 0.1
		~/.config/hypr/scripts/wallpaper.sh
		exit 1 
		;;

	"  Screen Copy")
		pkill rofi
		sleep 0.1
		~/.config/hypr/scripts/screen.sh
		exit 1
		;;

	"  Clipboard History")
		pkill rofi
		sleep 0.1
		~/.config/hypr/scripts/clipboard.sh
		exit 1
		;;

	*)
		exit 1
		;;
esac
