#!/bin/bash

# check if floatterm exists to not reopen it
win_id=`xdotool search --name floatterm`

if [ -z $win_id ]; then
    alacritty -t floatterm
else
    i3-msg [title="floatterm"] scratchpad show
    i3-msg [title="floatterm"] move position center
fi
