#!/bin/bash

device_name=$(xinput list --name-only | grep -i touchpad)

xinput set-prop "$device_name" "libinput Natural Scrolling Enabled" 1
xinput set-prop "$device_name" "libinput Tapping Enabled" 1
