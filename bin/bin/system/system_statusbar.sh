#!/bin/bash

killall -q lemonbar-generator

lemonbar-generator \
    | lemonbar \
        -f "StatusbarFont:size=12" \
        -f "Monospace:size=10" \
        -g "x30" \
        -B "#000000" \
        -F "#FFFFFF" \
    | system_statusbar_cmd_proc.sh
