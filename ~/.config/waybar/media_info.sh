#!/usr/bin/env bash

# Get currently active player and metadata
info=$(playerctl --player=%any metadata --format '{{ playerName }}: {{ artist }} - {{ title }}' 2>/dev/null)

# Only show output if something is playing
status=$(playerctl --player=%any status 2>/dev/null)
if [[ "$status" == "Playing" && -n "$info" ]]; then
    echo '{"text": "▶ '"$info"'", "class": "playing"}'
elif [[ "$status" == "Paused" && -n "$info" ]]; then
    echo '{"text": "⏸ '"$info"'", "class": "paused"}'
else
    echo '{"text": "", "class": "stopped"}'
fi
