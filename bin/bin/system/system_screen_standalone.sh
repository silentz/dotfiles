#!/bin/bash

default_mode=$(system_default_screen_resolution.sh | sed 's/_/x/g')
xrandr --output eDP-1 --mode "$default_mode"

monitors=$(system_list_monitors.sh)
for mon in $monitors; do
    if [ "$mon" != "eDP-1" ]; then
        xrandr --output "$mon" --off;
    fi
done;
