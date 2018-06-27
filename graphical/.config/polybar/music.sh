#!/bin/bash

icon_active="ﱘ"
icon_inactive="ﱙ"
color_active=$(polybar --dump=line-color top)
color_inactive=$(polybar --dump=foreground top)

player_status=$(playerctl status 2> /dev/null)
if [[ $? -eq 0 ]]; then
    metadata="$(playerctl metadata artist 2> /dev/null) - $(playerctl metadata title 2> /dev/null)"
fi

if [[ $player_status = "Playing" ]]; then
    echo "%{F$color_active}$icon_active $metadata"
elif [[ $player_status = "Paused" ]]; then
    echo "%{F$color_inactive}$icon_inactive $metadata"
else
    echo ""
fi
