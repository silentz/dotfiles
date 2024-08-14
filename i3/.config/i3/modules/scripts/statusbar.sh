#!/bin/bash

# Terminate already running bar instances
killall -q lemonbar_generator

# Wait until the processes have been shut down
while pgrep -u $UID -x lemonbar_generator >/dev/null; do sleep 0.1; done

$HOME/bin/statusbar &
