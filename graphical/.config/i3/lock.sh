#!/bin/bash

icon="/tmp/xkcd.png"

# Fallback if comic failed to download
if [ ! -s $icon ]; then
    icon="$HOME/.config/i3/lock.png"
fi
 
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
 
if [[ -f $icon ]]
then
    # placement x/y
    PX=0
    PY=0
    # lockscreen image info
    R=$(file $(readlink -f $icon) | grep -o '[0-9]* x [0-9]*')
    echo $R
    RX=$(echo $R | cut -d' ' -f 1)
    RY=$(echo $R | cut -d' ' -f 3)
 
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
 
        convert /tmp/screen.png $icon -geometry +$PX+$PY -composite -matte /tmp/screen.png
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

# Download random comic from xkcd for next lock
rm -f $icon
wget $(curl -sL "http://dynamic.xkcd.com/random/comic/" | grep "imgs.xkcd.com/comics/" |  awk '{print $5}') -O $icon

