echo -e "   Change Wallpaper\n  Screen Copy\n  Clipboard History"

case "$1" in
	"   Change Wallpaper")
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
