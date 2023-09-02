#!/bin/bash

touch ~/kek
curr=$(setxkbmap -query | grep layout | awk '{print $2}')

if [[ "$curr" == "us" ]]; then
    setxkbmap ru
else
    setxkbmap us
fi
