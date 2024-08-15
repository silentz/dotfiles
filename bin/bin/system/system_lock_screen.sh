#!/bin/bash

revert() {
    system_setup_dpms.sh
}

trap revert HUP INT TERM
xset +dpms dpms 5 5 5
i3lock -e -n -t -i ~/images/lock_02.png
revert
