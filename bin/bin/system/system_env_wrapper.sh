#!/bin/sh

export PATH="$PATH:$HOME/bin/system"
export PATH="$PATH:$HOME/stack/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/stack/lib"

eval "$@"
