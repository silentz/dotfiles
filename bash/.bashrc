# setup vte
source /etc/profile.d/vte.sh

# customize prompt look
export PS1="[\u@\h \[\e[34m\]\w\[\e[m\]]\\$ "

# add new or existing ssh-agent env vars
eval $(keychain --agents ssh --quick --quiet --eval)

# essential env vars
export EDITOR="nvim"
export CHROME_EXECUTABLE=/usr/bin/chromium
export ANDROID_HOME="$HOME/Android"

# setup path
pathadd() {
    export PATH="$PATH:$1"
}

pathadd "$HOME/bin"

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias lua='lua5.4'
