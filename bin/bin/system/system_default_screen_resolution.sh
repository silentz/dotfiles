#!/bin/bash

hostname=$(hostname)

if [ "$hostname" = "carbon" ]; then
    echo "1920_1080"
else
    echo "1920_1200"
fi
