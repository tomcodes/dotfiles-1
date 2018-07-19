#!/bin/bash

# Random position
POSITION=$(shuf -n1 -e bottom right left)

# Random size
SIZE=$(( ( RANDOM % 900 ) + 300 ))

# Generate random gopher
$HOME/Lab/go/bin/drawmeagopher

GOPHER="/tmp/gopher.png"

# Get dunst mute status
dunst_mute=$(~/.config/polybar/dunstmute.sh value)

# Pause dunst messages
~/.config/polybar/dunstmute.sh 1

# Lock
$HOME/.config/i3/blur_lock.sh \
    --logo $GOPHER \
    --logo-size $SIZE \
    --logo-position $POSITION \
    --logo-rotation true \
    --blur true

# Resume dunst with previous status
~/.config/polybar/dunstmute.sh $dunst_mute

# Remove temporary files
rm -f $GOPHER
