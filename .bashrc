# ~/.bashrc

if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

bind '"\t":menu-complete'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias clc='clear&&clear'
PS1="\u@h\h in \W ]\$(date + %k:%M:%S) ]> "