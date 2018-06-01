#!/bin/bash

# Get connected outputs
connected_outputs=$(xrandr | grep '\Wconnected' | awk '{ print $1 }')
connected_outputs=($connected_outputs)
connected_outputs_count=${#connected_outputs[@]}

# Get disconnected outputs
disconnected_outputs=$(xrandr | grep '\Wdisconnected' | awk '{ print $1 }')
disconnected_outputs=($disconnected_outputs)

# Get internal monitor (first monitor)
internal=${connected_outputs[0]}
only_internal=1

# Update internal
xrandr --output $internal --auto
if [ $connected_outputs_count -eq 1 ]; then
    notify-send "Monitor Update: only internal display" 
fi

# Update additional displays
for output in ${connected_outputs[@]}; do
    if [[ ! $output =~ ^$internal.*$ ]]; then
       xrandr --output $output --pos 0x0 --auto --right-of $internal
       notify-send "Monitor Update: $output plugged in"
    fi
done

# Update disconnected displays
for output in ${disconnected_outputs[@]}; do
    xrandr --output $output --off
done

# Restart Polybar
~/.config/polybar/launch.sh
