
# setup vte

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

# install oh my zsh

export __OH_MY_ZSH_DIR="$HOME/.oh-my-zsh/"
export __OH_MY_ZSH_CUSTOM_DIR="$__OH_MY_ZSH_DIR/custom/"


if [[ ! -d $__OH_MY_ZSH_DIR ]]; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git $__OH_MY_ZSH_DIR
fi

# custom plugins list

custom_plugins=(
    # ...
)

# install custom plugins

for plugin in $custom_plugins; do
    if [[ ! -d $__OH_MY_ZSH_CUSTOM_DIR/plugins/${plugin:t} ]]; then
        git clone https://github.com/${plugin} $__OH_MY_ZSH_CUSTOM_DIR/plugins/${plugin:t}
    fi
done

# disable autoupdate

zstyle ':omz:update' mode disabled

# setup oh my zsh plugins

plugins=(
)

# activate oh my zsh

PROMPT="%B%F{green}%n@%m%f:%F{blue}%~%f%b$ "
source ${__OH_MY_ZSH_DIR}/oh-my-zsh.sh

# setup environment

export EDITOR="nvim"
export ANDROID_HOME="$HOME/Android"
export CHROME_EXECUTABLE=/usr/bin/chromium-browser

path+="$HOME/.local/bin"
path+="$HOME/scripts"

path+="/usr/local/go/bin"
path+="/usr/local/texlive/2021/bin/x86_64-linux/"

path+="$HOME/jdk-18/bin"
path+="$HOME/flutter/bin"
path+="$ANDROID_HOME/platform-tools"
path+="$ANDROID_HOME/emulator"
path+="$ANDROID_HOME/cmdline-tools/latest/bin"

# aliases

alias lua='lua5.3'
