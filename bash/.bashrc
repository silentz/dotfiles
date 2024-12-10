# ========= [check interactivity] ==========

case $- in
    *i*) ;;
      *) return;;
esac

# ========= [history] ==========

export HISTFILE=/dev/null       # bash history file
export HISTSIZE=1000            # number of commands to remember in ram
export HISTFILESIZE=0           # number of commands to save to history file
export HISTCONTROL=ignoreboth   # do not save lines with space prefix
shopt -s histappend             # append histfile, do not overwrite

export PYTHONHISTFILE=/dev/null  # python history file
export LESSHISTFILE=/dev/null    # less history file

# ========= [bash-completion] ==========

if [[ -r /usr/share/bash-completion/bash_completion ]]; then
  . /usr/share/bash-completion/bash_completion
fi

# ========= [prompt] ==========

export PS1="[\u@\h \[\e[34m\]\w\[\e[m\]]\\$ "

# ========= [env vars] ==========

export EDITOR="vim"
export CHROME_EXECUTABLE=/usr/bin/chromium
export ANDROID_HOME="$HOME/Android"

# ========= [path env] ==========

pathadd() {
    export PATH="$PATH:$1"
}

pathadd "$HOME/bin"
pathadd "$HOME/bin/system"
pathadd "$HOME/bin/screen"
pathadd "$HOME/script"
pathadd "$HOME/stack/bin/"

pathadd "$HOME/go/bin"
pathadd "$HOME/flutter/bin"

# ========= [libs env] ==========

libadd() {
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$1"
}

libadd "$HOME/stack/lib"

# ========= [aliases] ==========

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias lua='lua5.4'
alias k='kubectl'
alias a='alacritty msg create-window --working-directory "$PWD"'

if ! command -v "zed" > /dev/null; then
    alias zed="zeditor";
fi

# ========= [autocomplete] ==========

source <(kubectl completion bash)
complete -o default -F __start_kubectl k
