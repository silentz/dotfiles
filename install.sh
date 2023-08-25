#/bin/bash

stow -t $HOME i3
stow -t $HOME polybar
stow -t $HOME bash
stow -t $HOME alacritty
stow -t $HOME nvim
stow -t $HOME gitui
stow -t $HOME images
stow -t $HOME fonts
fc-cache -f -v
