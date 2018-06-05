#!/bin/bash

file="/tmp/dunst_mute"

function mute() {
    pkill -u "$USER" -USR1 dunst &
    echo "1" > $file
}

function unmute() {
    pkill -u "$USER" -USR2 dunst &
    echo "0" > $file
}


# check value from tmp file
if [ ! -f $file ]; then
    muted=0
    echo "$muted" > $file
else
    muted=`cat $file`
fi

# update mute value if first argument defined
if [ $# -ne 0 ]; then
    if [ $1 == "0" ]; then
        unmute
    elif [ $1 == "1" ]; then
        mute
    elif [ $1 == "toggle" ] && [ $muted == "0" ]; then
        mute
    elif [ $1 == "toggle" ] && [ $muted == "1" ]; then
        unmute
    elif [ $1 == "restore" ] && [ $muted == "0"]; then
        unmute
    elif [ $1 == "restore" ] && [ $muted == "1"]; then
        mute 
    elif [ $1 == "value" ]; then
        echo $muted
    fi
else
    # return label to polybar
    if [ $muted == "0" ]; then
        echo ""
    else
        echo ""
    fi
fi
