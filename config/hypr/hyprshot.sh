#!/usr/bin/env bash

# Define options with icons
options=" Window\n Monitor\n Region"

# Launch Rofi
choice=$(echo -e "$options" | rofi -dmenu -i -p "Screenshot:" -theme ~/.config/rofi/config.rasi)

# Run corresponding command
case "$choice" in
    " Window")
        hyprshot -m window
        ;;
    " Monitor")
        hyprshot -m output
        ;;
    " Region")
        hyprshot -m region
        ;;
    *)
        exit 0
        ;;
esac

