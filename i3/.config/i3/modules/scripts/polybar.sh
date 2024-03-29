#!/bin/bash

# fetch all screens and primary one
screens=$(xrandr --listactivemonitors | grep -v "Monitors" | cut -d" " -f6)
primary=$(xrandr --query | grep primary | cut -d" " -f1)

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done

# launch polybar on all screens
for monitor in $screens; do
    if [[ "$monitor" == "$primary" ]]; then
        MONITOR="$monitor" polybar -q main &
    else
        # I also want to launch the same bar on second screen
        MONITOR="$monitor" polybar -q main &
    fi
done
