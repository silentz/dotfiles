
# setup vte

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

# setup env

pathadd() {
    export PATH="$PATH:$1"
}

# export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
export PS1="[\u@\h \W]\$ "

export EDITOR="nvim"
export ANDROID_HOME="$HOME/Android"
export CHROME_EXECUTABLE=/usr/bin/chromium-browser

pathadd "$HOME/.local/bin"
pathadd "$HOME/scripts"

# TODO: fix!!!
pathadd "/usr/local/texlive/2021/bin/x86_64-linux/"

pathadd "$HOME/node/bin"
pathadd "$HOME/jdk-18/bin"
pathadd "$HOME/flutter/bin"
pathadd "$ANDROID_HOME/platform-tools"
pathadd "$ANDROID_HOME/emulator"
pathadd "$ANDROID_HOME/cmdline-tools/latest/bin"

# aliases

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias lua='lua5.3'
