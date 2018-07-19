#!/bin/bash

# Define default values
ARG_LOGO="$HOME/.config/i3/lock.png"
ARG_LOGO_SIZE=200
ARG_LOGO_POSITION=center
ARG_LOGO_ROTATION=false
ARG_BLUR=true

# Usage function
function usage()
{
    echo -e "Lock i3 with a blurred background and a logo"
    echo -e ""
    echo -e "\t-h --help"
    echo -e "\t-l --logo Logo image path"
    echo -e "\t-s --logo-size Logo size in pixels"
    echo -e "\t-p --logo-position Logo position in [top|bottom|right|left|center]"
    echo -e "\t-r --logo-rotation Enable or disable logo rotation [false|true]"
    echo -e "\t-b --blur Make the background blurred [false|true]"
    echo -e ""
}

# Parse argument parameters
while [ "$1" != "" ]; do
    PARAM=$1
    VALUE=$2
    case $PARAM in
        --help | -h)
            usage
            exit
            ;;
        --logo | -l)
            ARG_LOGO=$VALUE
            ;;
        --logo-size | -s)
            if [[ $VALUE =~ ^-?[0-9]+$ ]]; then
                ARG_LOGO_SIZE=$VALUE
            fi
            ;;
        --logo-position | -p)
            if [[ "$VALUE" =~ ^(top|bottom|right|left|center)$ ]]; then
                ARG_LOGO_POSITION=$VALUE
            fi
            ;;
        --logo-rotation | -r)
            if [[ "$VALUE" =~ ^(true|false)$ ]]; then
                ARG_LOGO_ROTATION=$VALUE
            fi
            ;;
        --blur | -b)
            if [[ "$VALUE" =~ ^(true|false)$ ]]; then
                ARG_BLUR=$VALUE
            fi
            ;;
    esac
    shift
done

# Define final screen image location
SCREEN_IMG="/tmp/screen.png"

# Take a screenshot
scrot $SCREEN_IMG

# Scale it up and down for blurry effect
if [ "$ARG_BLUR" = true ]; then
    convert $SCREEN_IMG -scale 10% -scale 1000% $SCREEN_IMG
fi
 
if [[ -f $ARG_LOGO ]]
then
    # Define logo path
    LOGO_COMPUTED=$(dirname "$ARG_LOGO")/computed_$(basename $ARG_LOGO)

    # Resize image
    convert $ARG_LOGO -scale $ARG_LOGO_SIZE $LOGO_COMPUTED

    # Rotate logo according to position
    if [ "$ARG_LOGO_ROTATION" = true ]; then
        case $ARG_LOGO_POSITION in
            center )
                ROTATE=0
                ;;
            top )
                ROTATE=180
                ;;
            bottom )
                ROTATE=0
                ;;
            left )
                ROTATE=90
                ;;
            right )
                ROTATE=-90
                ;;
        esac
        convert $LOGO_COMPUTED -rotate $ROTATE $LOGO_COMPUTED
    fi

    # Lockscreen logo info
    LOGO_WIDTH=$(convert $(readlink -f $LOGO_COMPUTED) -print "%w" /dev/null)
    LOGO_HEIGHT=$(convert $(readlink -f $LOGO_COMPUTED) -print "%h" /dev/null)
 
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

        # Calculate logo position according to logo position
        case $ARG_LOGO_POSITION in
            center )
                LOGO_RELATIVE_X=$(($SCREEN_WIDTH/2 - $LOGO_WIDTH/2))
                LOGO_RELATIVE_Y=$(($SCREEN_HEIGHT/2 - $LOGO_HEIGHT/2))
                ;;
            top )
                LOGO_RELATIVE_X=$(($SCREEN_WIDTH/2 - $LOGO_WIDTH/2))
                LOGO_RELATIVE_Y=0
                ;;
            bottom )
                LOGO_RELATIVE_X=$(($SCREEN_WIDTH/2 - $LOGO_WIDTH/2))
                LOGO_RELATIVE_Y=$(($SCREEN_HEIGHT - $LOGO_HEIGHT))
                ;;
            left )
                LOGO_RELATIVE_X=0
                LOGO_RELATIVE_Y=$(($SCREEN_HEIGHT/2 - $LOGO_HEIGHT/2))
                ;;
            right )
                LOGO_RELATIVE_X=$(($SCREEN_WIDTH - $LOGO_WIDTH))
                LOGO_RELATIVE_Y=$(($SCREEN_HEIGHT/2 - $LOGO_HEIGHT/2))
                ;;
        esac

        # Get logo position
        LOGO_X=$(($SCREEN_X + $LOGO_RELATIVE_X))
        LOGO_Y=$(($SCREEN_Y + $LOGO_RELATIVE_Y))

        # Get logo maximum size to avoid overlapping
        LOGO_MAX_WIDTH=$(($SCREEN_WIDTH - $LOGO_RELATIVE_X))
        LOGO_MAX_HEIGHT=$(($SCREEN_HEIGHT - $LOGO_RELATIVE_Y))

        # Define screen image path
        SCREEN_LOGO=$(dirname "$LOGO_COMPUTED")/${SCREEN_NAME}_$(basename $LOGO_COMPUTED)

        # Crop image and save into screen image
        convert $LOGO_COMPUTED -crop ${LOGO_MAX_WIDTH}x${LOGO_MAX_HEIGHT}+0+0 $SCREEN_LOGO

        # Add img onto blurry background
        convert $SCREEN_IMG $SCREEN_LOGO -geometry +${LOGO_X}+${LOGO_Y} -composite -matte $SCREEN_IMG

        # Remove temporary image
        rm -f $SCREEN_LOGO
    done
fi

# Lock
i3lock -e -f -n -i $SCREEN_IMG

# Remove temporary files
rm -f $LOGO_COMPUTED
rm -f $SCREEN_IMG
