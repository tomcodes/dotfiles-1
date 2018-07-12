#!/bin/bash

# Generate random gopher
$HOME/Lab/go/bin/drawmeagopher

GOPHER="/tmp/gopher.png"
SCREEN_IMG="/tmp/screen.png"

# Fallback if image failed to download
if [ ! -s $GOPHER ]; then
    LOGO="$HOME/.config/i3/lock.png"
else
    LOGO=$GOPHER

    # Normalize image size
    convert $LOGO -scale 1100 $LOGO
fi

# Take a screenshot
scrot $SCREEN_IMG
# Scale it up and down for blurry effect
convert $SCREEN_IMG -scale 10% -scale 1000% $SCREEN_IMG
 
if [[ -f $LOGO ]]
then
    # Lockscreen logo info
    LOGO_WIDTH=$(convert $(readlink -f $LOGO) -print "%w" /dev/null)
    LOGO_HEIGHT=$(convert $(readlink -f $LOGO) -print "%h" /dev/null)
 
    SCREENS=$(xrandr --query | grep ' connected')

    # Internal Field Separator
    IFS=$'\n'

    for SCREEN in $SCREENS
    do
        # Remove primary string
        SCREEN=$(echo $SCREEN | sed 's/ primary//g')

        # Get screen name 
        SCREEN_NAME=$(echo $SCREEN | cut -f1 -d' ')

        # Get screen dimensions
        SCREEN=$(echo $SCREEN | cut -f3 -d' ')

        # Get screen width and height
        SCREEN_WIDTH=$(echo $SCREEN | cut -d'x' -f 1)
        SCREEN_HEIGHT=$(echo $SCREEN | cut -d'x' -f 2 | cut -d'+' -f 1)

        # Get screen position
        SCREEN_X=$(echo $SCREEN | cut -d'x' -f 2 | cut -d'+' -f 2)
        SCREEN_Y=$(echo $SCREEN | cut -d'x' -f 2 | cut -d'+' -f 3)

        # Get logo offsets
        LOGO_X_OFFSET=$(($SCREEN_WIDTH/2 - $LOGO_WIDTH/2))
        LOGO_Y_OFFSET=$(($SCREEN_HEIGHT/2 - $LOGO_HEIGHT/2))

        # Get logo position
        LOGO_X=$(($SCREEN_X + $LOGO_X_OFFSET))
        LOGO_Y=$(($SCREEN_Y + $LOGO_Y_OFFSET))

        # Get logo maximum size to avoid overlapping
        LOGO_MAX_WIDTH=$(($SCREEN_WIDTH - $LOGO_X_OFFSET))
        LOGO_MAX_HEIGHT=$(($SCREEN_HEIGHT - $LOGO_Y_OFFSET))

        # Define screen image path
        SCREEN_LOGO=$(dirname "$LOGO")/${SCREEN_NAME}_$(basename $LOGO)

        # Crop image and save into screen image
        convert $LOGO -crop ${LOGO_MAX_WIDTH}x${LOGO_MAX_HEIGHT}+0+0 $SCREEN_LOGO

        # Add img onto blurry background
        convert $SCREEN_IMG $SCREEN_LOGO -geometry +${LOGO_X}+${LOGO_Y} -composite -matte $SCREEN_IMG

        # Remove temporary image
        rm -f $SCREEN_LOGO
    done
fi

# Get dunst mute status
dunst_mute=$(~/.config/polybar/dunstmute.sh value)

# Pause dunst messages
~/.config/polybar/dunstmute.sh 1

# Lock
i3lock -e -f -n -i $SCREEN_IMG

# Resume dunst with previous status
~/.config/polybar/dunstmute.sh $dunst_mute

# Remove temporary files
rm -f $SCREEN_IMG
rm -f $GOPHER
