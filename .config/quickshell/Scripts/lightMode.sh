#!/usr/bin/env bash
set -euo pipefail

STATE_DIR="$HOME/.config/theme"
STATE_FILE="$STATE_DIR/theme-state"
WALLPAPER="$HOME/.cache/mineral/wallpaper.png"

mkdir -p "$STATE_DIR"
[[ -f "$STATE_FILE" ]] || echo "LIGHT_MODE=0" > "$STATE_FILE"

# helper: read and normalize current value
get_current() {
  # shellcheck disable=SC1090
  . "$STATE_FILE"
  case "${LIGHT_MODE:-0}" in
    1|true|TRUE|True) echo 1 ;;
    *)                echo 0 ;;
  esac
}

# no args → just print the current value
if [[ $# -eq 0 ]]; then
  get_current
  exit 0
fi

# args: "light", "dark", or "toggle"
want="$1"
cur="$(get_current)"

case "$want" in
  light|LIGHT|Light) new=1 ;;
  dark|DARK|Dark)    new=0 ;;
  toggle|TOGGLE|Toggle) new=$((1-cur)) ;;
  *) echo "Usage: $0 [light|dark|toggle]" >&2; exit 1 ;;
esac

# write new value
echo "LIGHT_MODE=$new" > "$STATE_FILE"

# optional: reapply wal immediately using cached wallpaper
if [[ -f "$HOME/.cache/mineral/wallpaper.png" ]]; then
  if [[ $new -eq 1 ]]; then
    wal --cols16 -l -i $WALLPAPER
  else
    wal --cols16    -i $WALLPAPER
  fi
fi

notify-send "Theme mode" "LIGHT_MODE=$new (1=light, 0=dark)" 2>/dev/null || true
echo "$new"
