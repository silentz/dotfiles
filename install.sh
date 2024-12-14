#/bin/bash

stow -t $HOME alacritty
stow -t $HOME bash
stow -t $HOME bin
stow -t $HOME dunst
stow -t $HOME fonts
stow -t $HOME gsimplecal
stow -t $HOME gtk
stow -t $HOME i3
stow -t $HOME images
stow -t $HOME rofi
stow -t $HOME vim
stow -t $HOME wget
stow -t $HOME yazi
stow -t $HOME zed

fc-cache -f -v
