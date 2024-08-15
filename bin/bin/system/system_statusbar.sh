#!/bin/bash

killall -q lemonbar_generator

lemonbar_generator | lemonbar \
    -f "StatusbarFont:size=12" \
    -f "Monospace:size=10" \
    -g "x30" \
    -B "#000000" \
    -F "#FFFFFF"