#!/bin/sh
#
# z3bra - 2014 (c) wtfpl
# arrange windows in a tiled pattern

# Resolution
width=1920
height=1080

# default values for gaps and master area
panel=0
gap=100

# Master is half of the screen width minus
master=$((width / 2 - $((gap / 2))))

# get current window id and its borderwidth
pfw=$(pfw)
bw=$(wattr b "$pfw")

# get the number of windows to put in the stacking area
max=$(lsw | grep -v $pfw | wc -l)

# List number of windows with "tile_ignore" in name
ignore=$(wname $(lsw) | grep "tile_ignore" | wc -l)

# calculate usable screen size (without borders and gaps)
sw=$((width - gap - 2*bw))
sh=$((height - gap - 2*bw - panel))

y=$((gap + panel))

# put current window in master area

# If windowname includes "tile_ignore", exit
if [[ $(wname $pfw) == *"tile_ignore"* ]]; then
    exit

# If there's only one unignored window open tile it to the full width of the screen
elif [[ $(($(lsw | wc -l) - $ignore)) == 1 ]]; then
    sw=$((sw - gap))
    sh=$((sh - gap))
    wtp $gap $gap $sw $sh $pfw

# Prevent tiling of ignored windows
else
    wtp $gap $y $((master - gap - 2*bw)) $((sh - gap)) $pfw
fi

# Put the tiled windows at the bottom of the stack
chwso -l $pfw

# and now, stack up all remaining windows on the right
x=$((master + gap))
w=$((sw - master - gap))
h=$((sh / $((max - ignore)) - gap))

for wid in $(lsw | grep -v $pfw); do
    # If focused window's name doesn't include "tile_ignore", tile it!
    if [[ $(wname $wid) != *"tile_ignore"* ]]; then
        wtp $x $y $w $h $wid
        y=$((y + h + gap))

        # Put the tiled windows at the bottom of the stack
        chwso -l $wid
    fi
done