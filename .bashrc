#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export TERM=xterm-256color

dotdir=~/dotfiles
source $dotdir/alias
source $dotdir/functions

thisPC=`hostname`
if [ $thisPC = "inspiron-1525" ]
then
    source $dotdir/only_laptop
else
    source $dotdir/only_michelli
fi

PS1='[\u@\h \W]\$ '

#Define VIM as default editor to GIT, instead of VI
export GIT_EDITOR=vim

# Bruno - keychain - enable and manage ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    rm -f ~/.ssh-socket
    ssh-agent -a ~/.ssh-socket > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi
#export GPG_TTY=$(tty)
#export SSH_ASKPASS=ksshaskpass

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
command cat ~/.log_error 2>/dev/null

# Enable vi mode on bash
set -o vi

source /home/bruno/.config/broot/launcher/bash/br
