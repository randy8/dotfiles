# ~/.bashrc
 
# hello() {
#     echo "Hello, $USER!"
#     ls
# }

# # New session startup
# hello

# Cycles through possible name endings
# if not natively available already.
bind '"\t":menu-complete'
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"
bind "set menu-complete-display-prefix on"


alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias clc='clear&&clear' 
# Symlink for Sublime:
# ln -s <dir of executable> /usr/local/bin/subl

# -human readable size, -all including hidden directories, -long list            
# -Filetype indicator, -owner listed but not group                            
alias lls='ls -halFo'                                                            
                                                                                 
# Color-coded with fixed width columns and abbreviated commit hash               
alias glog="git log --pretty=format:'%C(yellow)%h|%Cred%ad|%Cblue%an|%Cgreen%d %Creset%s' --date=short | column -ts'|' | less -r"

# Debian, new RPM, old RPM
if type -P apt-get 1>/dev/null 2>&1; then                                        
    INSTALLER="apt-get"                                                          
elif type -P dnf 1>/dev/null 2>&1; then                                          
    INSTALLER="dnf"                                                              
elif type -P yum 1>/dev/null 2>&1; then                                          
    INSTALLER="yum"                                                              
fi  

alias install='$INSTALLER install'
alias uninstall='$INSTALLER remove'                                  
alias update='$INSTALLER update'                                                 
alias upgrade='$INSTALLER upgrade'                                               
alias sinstall='sudo $INSTALLER install'                                         
alias suninstall='sudo $INSTALLER remove'                            
alias supdate='sudo $INSTALLER update'                                           
alias supgrade='sudo $INSTALLER upgrade' 

# .bash_history is forever 
export HISTSIZE=-1
export HISTFILESIZE=-1 
export HISTCONTROL=ignoredups:erasedups # No duplicates
shopt -s histappend # Append not overwrite

# -n reads from bash_history; -w saves history to file/erases dups
# -c prevents clearing the history buffer; -r restores history buffer from file
export PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

# For macOS: outputs current battery %, time remaining/to charge, 
# cycle count, temp, and calculates battery design 
# capability index.
function battery() {
    pmset -g batt; ioreg -brc AppleSmartBattery | egrep "CycleCount|Temperature"; echo $(ioreg -l -n AppleSmartBattery -r | grep MaxCapacity | awk '{print $3}') / $(ioreg -l -n AppleSmartBattery -r | grep DesignCapacity | awk '{print $3}') \* 100 | bc -l
}

# Bash prompt
# ┌─USER_green@HOST_blue in DIRECTORY_yellow at TIME_purple
# └─ <COMMANDS>
export PS1="┌─\[\e[1;32m\u\e[0;37m\]\e[0m@\e[1;34m\h\e[0;37m \e[0min \e[1;33m\w\e[0;37m \e[0mat \e[1;35m\t\n\[\e[0;37m\]└─ \[\e[0m\]"
