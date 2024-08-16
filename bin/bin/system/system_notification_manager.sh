#!/bin/bash

killall -q dunst
dbus-launch dunst --config ~/.config/dunst/dunstrc
