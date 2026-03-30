#!/usr/bin/env bash
if [ -f /usr/bin/fastfetch ]; then
	fastfetch
fi

# Autostart ssh
if ! pgrep -x "ssh-agent" > /dev/null; then
    eval "$(ssh-agent -s)"
fi

# Disable the bell
bind "set bell-style none"
# Expand the history size
export HISTFILESIZE=10000
export HISTSIZE=500

# Ignore duplicate and commands that begin with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Alias's to modified commands
alias cd='change_directory'
change_directory(){
	if [ $# -eq 0 ]; then
		\cd ~
	else
		\cd "$1"
	fi
	if [[ $? == 0 ]]; then
		ls
	fi	
}
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash -v'
alias ping='ping -c 5'
alias less='less -R'
alias pacman='sudo pacman'
alias vi='nvim'
alias vim='nvim'
alias svi='sudo vi'
alias yayf="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"
alias grep='grep --color=auto'

# cd into the old directory
alias bd='cd "$OLDPWD"'

# Remove a directory and all files
alias rmd='/bin/rm  --recursive --force --verbose '

# Shortcuts
alias sys='systemctl'

# Search running processes
alias p="ps aux | grep "

eval "$(starship init bash)"
