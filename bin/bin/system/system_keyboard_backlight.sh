#!/bin/bash

device=$(light -L | grep kbd | head -n 1)   # find keybaord device
device=$(echo $device)                      # remove leading and trailing whitespace

backlight_old=$(light -s "$device" -G)
light -s "$device" -A 50
backlight_new=$(light -s "$device" -G)

if [[ "$backlight_old" == "$backlight_new" ]]; then
    # set to zero if maximum level reached
    light -s "$device" -S 0
fi
