#!/bin/bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon=""
color_playing=$(polybar --dump=line-color top)
color_paused=$(polybar --dump=foreground top)

player_status=$(playerctl status 2> /dev/null)
if [[ $? -eq 0 ]]; then
    metadata="$(playerctl metadata artist) - $(playerctl metadata title)"
fi

# Foreground color formatting tags are optional
if [[ $player_status = "Playing" ]]; then
    echo "%{F$color_playing}$icon $metadata"       # Orange when playing
elif [[ $player_status = "Paused" ]]; then
    echo "%{F$color_paused}$icon $metadata"       # Greyed out info when paused
else
    echo "%{F$color_paused}$icon"                 # Greyed out icon when stopped
fi
