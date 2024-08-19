#!/bin/bash

xrandr --query | grep -v disconnected | grep connected | awk '{print $1}'
