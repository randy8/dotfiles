# ~/.bashrc

bind '"\t":menu-complete'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias clc='clear&&clear' 
alias subl='open -a "Sublime Text"'

# Outputs current battery %, time remaining/to charge, 
# cycle count, temp, and calculates battery design 
# capability index.
function battery() {
	pmset -g batt; ioreg -brc AppleSmartBattery | egrep "CycleCount|Temperature"; echo $(ioreg -l -n AppleSmartBattery -r | grep MaxCapacity | awk '{print $3}') / $(ioreg -l -n AppleSmartBattery -r | grep DesignCapacity | awk '{print $3}') \* 100 | bc -l
}

# With time
# PS1="[\u@\h in \w \t]\\$ "

PS1="[\u@\h in \w]\\$ "
