#!/bin/bash

killall -q lemonbar_generator

lemonbar_generator | while IFS= read -r line; do
    echo "%{SnEDP-1} $line";
done | lemonbar \
    -f "StatusbarFont:size=12" \
    -f "Monospace:size=10" \
    -g "x30" \
    -B "#000000" \
    -F "#FFFFFF"
