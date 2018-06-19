#!/bin/bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon_active="ﱘ"
icon_inactive="ﱙ"
color_active=$(polybar --dump=line-color top)
color_inactive=$(polybar --dump=foreground top)

player_status=$(playerctl status 2> /dev/null)
if [[ $? -eq 0 ]]; then
    metadata="$(playerctl metadata artist) - $(playerctl metadata title)"
fi

# Foreground color formatting tags are optional
if [[ $player_status = "Playing" ]]; then
    echo "%{F$color_active}$icon_active $metadata"       # Orange when playing
elif [[ $player_status = "Paused" ]]; then
    echo "%{F$color_inactive}$icon_inactive $metadata"       # Greyed out info when paused
else
    echo "%{F$color_inactive}$icon_inactive"                 # Greyed out icon when stopped
fi
