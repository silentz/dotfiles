#!/bin/bash

while IFS=$'\n' read -r line; do
    case $line in
        datetime-event)
            gsimplecal &
            ;;
        workspace-event*)
            workspace_name="${line:16:128}"
            i3-msg workspace "$workspace_name"
            ;;
        *)
            echo "unknown: $line"
            ;;
    esac
done
