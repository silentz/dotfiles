# ========= [check interactivity] ==========

case $- in
    *i*) ;;
      *) return;;
esac

# ========= [history] ==========

export HISTSIZE=1000            # number of commands to remember in ram
export HISTFILESIZE=-1          # unlimit bash history file size
export HISTCONTROL=ignoreboth   # do not save lines with space prefix
shopt -s histappend             # append histfile, do not overwrite

# ========= [bash-completion] ==========

if [[ -r /usr/share/bash-completion/bash_completion ]]; then
  . /usr/share/bash-completion/bash_completion
fi

# ========= [prompt] ==========

export PS1="[\u@\h \[\e[34m\]\w\[\e[m\]]\\$ "

# ========= [common ssh-agent] ==========

eval $(keychain --agents ssh --quick --quiet --eval)

# ========= [env vars] ==========

export EDITOR="nvim"
export CHROME_EXECUTABLE=/usr/bin/chromium
export ANDROID_HOME="$HOME/Android"

# ========= [path env] ==========

pathadd() {
    export PATH="$PATH:$1"
}

pathadd "$HOME/bin"
pathadd "$HOME/script"
pathadd "$HOME/stack/bin/"

pathadd "$HOME/go/bin"
pathadd "$HOME/flutter/bin"

# ========= [aliases] ==========

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias lua='lua5.4'
