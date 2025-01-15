#!/bin/bash

CURRENT_WALLPAPER_TRACKING_FILE="$HOME/.wallpaper"
CURRENT_WALLPAPER=$(cat "$CURRENT_WALLPAPER_TRACKING_FILE")
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
PREVIOUS_WALLPAPER=$(ls -1 "$WALLPAPER_DIR" | grep -B 1 "$(cat "$CURRENT_WALLPAPER_TRACKING_FILE")" | head -n 1)
if [[ "$CURRENT_WALLPAPER" == "$PREVIOUS_WALLPAPER" ]]; then
  PREVIOUS_WALLPAPER=$(ls -1 "$WALLPAPER_DIR" | tail -n 1)
fi
echo "$PREVIOUS_WALLPAPER" > "$CURRENT_WALLPAPER_TRACKING_FILE"

PREVIOUS_WALLPAPER_FILE="$HOME/.wallpaper.jpg"
cp "$WALLPAPER_DIR/$PREVIOUS_WALLPAPER" "$PREVIOUS_WALLPAPER_FILE"

swaymsg 'output * bg $HOME/.wallpaper.jpg fill'
# nitrogen --set-zoom-fill ~/.wallpaper.jpg
# /home/marco/.local/bin/wal -i "$WALLPAPER_DIR/$PREVIOUS_WALLPAPER"
#gsettings set org.gnome.desktop.background picture-uri "file://$PREVIOUS_WALLPAPER_FILE"
#gsettings set org.gnome.desktop.screensaver picture-uri "file://$PREVIOUS_WALLPAPER_FILE"
#feh --bg-fill "$PREVIOUS_WALLPAPER_FILE"

logger "Changed wallpaper to: $PREVIOUS_WALLPAPER"
notify-send -u low -a "Previous wallpaper:" "Changed wallpaper to $PREVIOUS_WALLPAPER"

