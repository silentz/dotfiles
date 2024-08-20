#!/bin/bash

all_layouts=$(xkblayout-state print '%S')
current_layout=$(xkblayout-state print '%s')

found_index="0"
current_index="0"

for layout in $all_layouts; do
    if [ "$layout" = "$current_layout" ]; then
        found_index="$current_index";
    fi
    current_index=$(expr "$current_index" + 1)
done

next_index=$(expr "$found_index" + 1)
next_index=$(expr "$next_index" % "$current_index")
next_index=$(expr "$next_index" + 1)

next_layout=$(echo "$all_layouts" | sed "${next_index}q;d")
# TODO: xkb-switch
lemonbar-generator-client keyboard
