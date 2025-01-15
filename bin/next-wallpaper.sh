#!/bin/bash

CURRENT_WALLPAPER_TRACKING_FILE="$HOME/.wallpaper"
CURRENT_WALLPAPER=$(cat "$CURRENT_WALLPAPER_TRACKING_FILE")
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
NEXT_WALLPAPER=$(ls -1 "$WALLPAPER_DIR" | grep -A 1 "$CURRENT_WALLPAPER" | tail -n 1)
if [[ "$CURRENT_WALLPAPER" == "$NEXT_WALLPAPER" ]]; then
  NEXT_WALLPAPER=$(ls -1 "$WALLPAPER_DIR" | head -n 1)
fi
echo "$NEXT_WALLPAPER" > "$CURRENT_WALLPAPER_TRACKING_FILE"

if [[ $1 == "--delete" ]]; then
  echo "Deleting current..."
  hash=$(echo $CURRENT_WALLPAPER | cut -c1-10)
  #rm -v ~/.i3mm/img/cache/*$hash* 
  gio trash "$WALLPAPER_DIR/$CURRENT_WALLPAPER"
fi

NEXT_WALLPAPER_FILE="$HOME/.wallpaper.jpg"
cp "$WALLPAPER_DIR/$NEXT_WALLPAPER" "$NEXT_WALLPAPER_FILE"
swaymsg 'output * bg $HOME/.wallpaper.jpg fill'
# nitrogen --set-zoom-fill .wallpaper.jpg
# /home/marco/.local/bin/wal -i "$WALLPAPER_DIR/$NEXT_WALLPAPER"
#gsettings set org.gnome.desktop.background picture-uri "file://$NEXT_WALLPAPER_FILE"
#gsettings set org.gnome.desktop.screensaver picture-uri "file://$NEXT_WALLPAPER_FILE"
#feh --no-fehbg --bg-fill "$NEXT_WALLPAPER_FILE"

logger "Changed wallpaper to: $NEXT_WALLPAPER"
notify-send -u low -a "Next wallpaper:" "Changed wallpaper to $NEXT_WALLPAPER"
