#/bin/bash

stow -t $HOME bash
stow -t $HOME gitui

stow -t $HOME fonts
fc-cache -f -v
