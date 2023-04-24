# dotfiles

## Setup

1. Install GNU Stow
```
pacman -S stow
apt install stow
...
```

2. Go to config dir of the repo:
```
cd config
```

3. Stow required configuration:
```
stow -t $HOME neovim
stow -t $HOME fonts
...
```
