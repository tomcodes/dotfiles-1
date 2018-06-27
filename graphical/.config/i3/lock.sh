#!/bin/bash

downloaded_img="/tmp/lock.png"
fallback_img="$HOME/.config/i3/lock.png"

# Fallback if image failed to download
if [ ! -s $downloaded_img ]; then
    img=$fallback_img
else
    img=$downloaded_img
fi
 
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
 
if [[ -f $img ]]
then
    # placement x/y
    PX=0
    PY=0
    # lockscreen image info
    RX=$(convert $(readlink -f $img) -print "%w" /dev/null)
    RY=$(convert $(readlink -f $img) -print "%h" /dev/null)
 
    SR=$(xrandr --query | grep ' connected')
    IFS=$'\n'
    for RES in $SR
    do
        # monitor position/offset
        RES=$(echo $RES | sed 's/ primary//g')
        RES=$(echo $RES | cut -f3 -d' ')
        SRX=$(echo $RES | cut -d'x' -f 1)                   # x pos
        SRY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 1)  # y pos
        SROX=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 2) # x offset
        SROY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 3) # y offset
        PX=$(($SROX + $SRX/2 - $RX/2))
        PY=$(($SROY + $SRY/2 - $RY/2))
 
        convert /tmp/screen.png $img -geometry +$PX+$PY -composite -matte /tmp/screen.png
        echo "done"
    done
fi

# get dunst mute status
dunst_mute=$(~/.config/polybar/dunstmute.sh value)

# pause dunst messages
~/.config/polybar/dunstmute.sh 1

# lock
i3lock -e -f -n -i /tmp/screen.png

# resume dunst with previous status
~/.config/polybar/dunstmute.sh $dunst_mute

# Download random image for next lock
theme=nature
wget https://loremflickr.com/800/600/$theme -O $downloaded_img
