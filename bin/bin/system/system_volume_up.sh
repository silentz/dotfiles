#!/bin/bash

amixer -q -D pulse sset Master 5%+
lemonbar-generator-client volume
