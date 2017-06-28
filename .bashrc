# ~/.bashrc
 
hello() {
    echo "Hello, $USER!"
    ls
}

# New session startup
hello

# Cycles through possible name endings
# if not natively available already.
bind '"\t":menu-complete'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias clc='clear&&clear' 
#alias subl='open -a "Sublime Text"'
alias myip='curl ifconfig.co'
alias lls='ls -halFg'  

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

# Outputs current battery %, time remaining/to charge, 
# cycle count, temp, and calculates battery design 
# capability index.
function battery() {
    pmset -g batt; ioreg -brc AppleSmartBattery | egrep "CycleCount|Temperature"; echo $(ioreg -l -n AppleSmartBattery -r | grep MaxCapacity | awk '{print $3}') / $(ioreg -l -n AppleSmartBattery -r | grep DesignCapacity | awk '{print $3}') \* 100 | bc -l
}

# Bash prompt
username='\e[1;34m\u\e[0m';
hostname='\e[0;32m\h\e[0m';
directory='\e[1;36m\W\e[0m';
# time='\t'
export PS1="[$username@$hostname in $directory]\\$ "
