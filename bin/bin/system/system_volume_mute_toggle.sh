#!/bin/bash

amixer -q -D pulse sset Master toggle
lemonbar-generator-client volume
