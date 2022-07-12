# ~/.bashrc
 
# Cycles through possible name endings
# if not natively available already.
bind '"\t":menu-complete'
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"
bind "set menu-complete-display-prefix on"

# Asks for confirmation when removing, copying, or moving files
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Clears terminal window entirely (ganked from MATLAB)
alias clc='clear&&clear' 

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

# Bash history settings                                                          
HISTSIZE=99999                                                                   
HISTFILESIZE=99999                                                               
HISTTIMEFORMAT="%m/%d/%y %T " # Time stamp                                       
# export HISTCONTROL=ignoredups:erasedups # No duplicates                        
# shopt -s histappend # Append not overwrite                                     
# Going through history causes duplicates (e.g. if 'vim ~/.bashrc' was my last command, it'll 
# appear multiple times when going through history via up arrow). Likely culprit is below due 
# to the order in which the bashrc is read                                       
# -n reads from bash_history; -w saves history to file/erases dups               
# -c prevents clearing the history buffer; -r restores history buffer from file  
# export PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

# Get current branch
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo " [${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# Display git status with a symbol
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

export USER_GREEN="\[\e[1;32m\]\u\[\e[m\]"
export HOST_BLUE="\[\e[1;34m\]\h\[\e[m\]"
export CURR_DIR_YELLOW="\[\e[1;33m\]\w\[\e[m\]"
export PARSE_GIT_BRANCH_CYAN="\[\e[1;36m\]\$(parse_git_branch)\[\e[m\]"
export TIME_PURPLE="\[\e[1;35m\]\t\[\e[m\]\n"
# ┌─USER@HOST in DIR [BRANCH] at TIME
# └─ <COMMANDS>
export PS1="┌─${USER_GREEN}@${HOST_BLUE} in ${CURR_DIR_YELLOW}${PARSE_GIT_BRANCH_CYAN} at ${TIME_PURPLE}└─"
