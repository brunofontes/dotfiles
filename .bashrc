#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


dotdir=~/dotfiles
source $dotdir/.alias
source $dotdir/.functions
source $dotdir/.only_laptop
source $dotdir/.only_michelli

PS1='[\u@\h \W]\$ '

#Define VIM as default editor to GIT, instead of VI
export GIT_EDITOR=vim

eval $(keychain --eval --quiet)

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi
