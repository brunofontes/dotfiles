# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/home/bruno/.oh-my-zsh
  export XDEBUG_CONFIG="idekey=VSCODE"

# Path to my personal npm file path
export PATH=~/.npm-global/bin:$PATH

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib

export TERM=xterm-256color
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
#ZSH_THEME="pure"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git gitfast sudo docker gpg-agent homestead laravel ufw
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
 export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"
#eval $(ssh-agent) > /dev/null
export SSH_AUTH_SOCK=/home/bruno/.ssh-socket
export SSH_AUTH_SOCK
#
# Bruno - keychain - enable and manage ssh-agent
#eval $(keychain --eval --quiet)
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    rm -f ~/.ssh-socket
    ssh-agent -a ~/.ssh-socket > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

export SSH_ASKPASS="ksshaskpass"
#export SSH_AUTH_SOCK=/run/user/1000/keyring/.ssh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Read alias and functions
dotdir=~/dotfiles
source $dotdir/alias
source $dotdir/functions

# Load specific files for each PC
thisPC=`hostname`
if [ $thisPC = "inspiron-1525" ]
then
    source $dotdir/only_laptop
else
    source $dotdir/only_michelli
fi


#Enable menu select
zstyle ':completion:*' menu select

# Enable tree view for kill completion
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -e -o pid,user,tty,cmd'

#Docker-compose autocomplete para o Zsh
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

#GPG Key
#export GPG_TTY=$(tty)

#Bruno - Keep "LESS" content on screen when exit
export LESS="-XFR"

#Avoid the exit command to be included on commands history
export HISTIGNORE="&:[ ]*:exit"

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

# Enable vi mode on bash
# set -o vi
# Remap CapsLock to Esc and Esc to CapsLock
# [[ $(xmodmap -pke | grep Escape) = "keycode  66 = Escape NoSymbol Escape" ]] || ( /bin/xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' && echo 'Caps changed to Escape' )
# [[ $(xmodmap -pke | grep "Caps_Lock") = "keycode   9 = Caps_Lock NoSymbol Caps_Lock" ]] || ( /bin/xmodmap -e 'keycode 9 = Caps_Lock NoSymbol Caps_Lock' && echo 'Escape changed to Caps' )

# Directory shortcuts
hash -d linux=$HOME/Apps/linuxShortcuts  # cd ~linux to open folder
hash -d systemd=/etc/systemd/system

#screenfetch
command cat ~/.log_error 2>/dev/null

#Fix z error message on Zsh plugin
if [ "$_Z_NO_RESOLVE_SYMLINKS" ]; then
    _z_precmd() {
        (_z --add "${PWD:a}" &)
		: $RANDOM
    }
else
    _z_precmd() {
        (_z --add "${PWD:A}" &)
		: $RANDOM
    }
fi

#Enable dep (deployer) autocomplete
source ~/.deployer_completion

if [ "$XTERM_VERSION" -a -z "$TMUX" ];
then
    tmux new -t UXTerm_`date +%Hh%Mm`
fi

#Should be the last command to be run
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
