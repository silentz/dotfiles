#/bin/bash

stow -t $HOME bash
stow -t $HOME alacritty
stow -t $HOME gitui

stow -t $HOME fonts
fc-cache -f -v
