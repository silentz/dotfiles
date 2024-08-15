#!/bin/bash

killall -q xss-lock
xss-lock --transfer-sleep-lock -- system_lock_screen.sh
