#!/bin/bash

revert() {
    system_setup_dpms.sh
}

xkb-switch -s us
trap revert HUP INT TERM
xset +dpms dpms 5 5 5
i3lock -e -n -t -i ~/images/lock_1920_1080.png
revert
