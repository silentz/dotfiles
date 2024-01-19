#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 0.1; done

screens=$(xrandr --listactivemonitors | grep -v "Monitors" | cut -d" " -f6)
primary=$(xrandr --query | grep primary | cut -d" " -f1)

for monitor in $screens; do
    if [[ "$monitor" == "$primary" ]]; then
        MONITOR="$monitor" polybar main &
    else
        # I also want to launch the same bar on second screen
        MONITOR="$monitor" polybar main &
    fi
done
