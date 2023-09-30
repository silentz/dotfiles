#!/bin/bash

move_type=$1
current=$(i3-msg -t get_workspaces | jq 'map(select(.focused))[0].num')

if [[ "$move_type" == "left" || "$move_type" == "up" ]]; then
    ((current--))
    if [[ "$current" -lt 1 ]]; then
        current="1"
    fi
else
    ((current++))
    if [[ "$current" -gt 10 ]]; then
        current="10"
    fi
fi

i3-msg workspace "$current"
