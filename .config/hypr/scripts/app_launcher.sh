entries="󰋩  Change Wallpaper\n  Screen Copy\n  Clipboard History\n  Emojis\n󰈀 Network Manager\n  Audio Settings\n  Mission Center"

APP=$(echo -e "$entries" | rofi -dmenu -i -theme "$HOME/dotfiles/.config/rofi/styles/menu.rasi")

case "$APP" in
	"󰋩  Change Wallpaper")
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

  "  Emojis")
    pkill rofi
    sleep 0.1
    ~/.config/hypr/scripts/emoji.sh
    exit 1
    ;;

  "󰈀  Network Manager")
    pkill rofi
    sleep 0.1
    nm-connection-editor
    exit 1
    ;;

  "  Audio Settings")
    pkill rofi
    sleep 0.1
    pavucontrol
    exit 1
    ;;

  "  Mission Center")
    pkill rofi
    sleep 0.1
    missioncenter
    exit 1
    ;;

	*)
		exit 1
		;;
esac
