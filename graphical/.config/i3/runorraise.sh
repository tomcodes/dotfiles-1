#!/bin/sh

if [ "$#" -eq 3 ]; then
    criteria=$1
    criteria_value=$2
    exec_command=$3
elif [ "$#" -eq 2 ]; then
    criteria=$1
    criteria_value=$2
    exec_command=$2
elif [ "$#" -eq 1 ]; then
    criteria="class"
    criteria_value=$1
    exec_command=$1
else
    exit 1
fi

case "$criteria" in
    "class" )
        count=`xdotool search --limit 1 --class "$criteria_value" | wc -l`
        i3wm_criteria="class";;
    "instance" )
        count=`xdotool search --limit 1 --classname "$criteria_value" | wc -l`
        i3wm_criteria="instance";;
    "name" )
        count=`xdotool search --limit 1 --name "$criteria_value" | wc -l`
        i3wm_criteria="title";;
esac
if [ "$count" -eq 0 ]; then
   $exec_command
else
    i3-msg "[$i3wm_criteria=(?i)$criteria_value] focus"
fi
