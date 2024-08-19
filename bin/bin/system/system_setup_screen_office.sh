#!/bin/bash

xrandr --output DP-3-2 --mode 1920x1080 --pos 0x0
xrandr --output DP-3-3 --mode 1920x1080 --left-of DP-3-2
xrandr --output eDP-1  --mode 1920x1200 --pos 960x1080
