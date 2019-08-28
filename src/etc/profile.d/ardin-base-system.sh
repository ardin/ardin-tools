#!/usr/bin/env bash

# prompt
if [ $UID -eq 0 ]; then
    PS1='\[\033[0;31m\]\u\[\033[0;31m\]@\[\033[1;31m\]\H\[\033[0;33m\] \w \[\033[1m\]\$\[\033[0m\] '
else
    PS1='\[\033[0;32m\]\u\[\033[0;32m\]@\[\033[1;32m\]\H\[\033[0;33m\] \w \[\033[1m\]\$\[\033[0m\] '
fi

# history
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export HISTCONTROL=ignoredups
export HISTTIMEFORMAT="%F %H:%M:%S "

