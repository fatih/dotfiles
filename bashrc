###############
# Source other files

# Senstive functions which are not pushed to Github
# It contains GOPATH, some functions, aliases etc...
[ -r ~/.bash_private ] && source ~/.bash_private


# Get it from the original Git repo: 
# https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
source ~/.git-prompt.sh

# On Mac OS X: brew install bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# On Mac OS X: brew install fasd
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache


# On Mac OS X: brew reinstall --HEAD fzf

###############
# Aliases (custom)
alias ..='cd ..'
alias mvim='/usr/local/Cellar/macvim/HEAD/bin/mvim -v'
alias vim='/usr/local/Cellar/macvim/HEAD/bin/mvim -v'
alias vi='/usr/local/Cellar/macvim/HEAD/bin/mvim -v'
alias ls='ls -GpF' # Mac OSX specific
alias ll='ls -alGpF' # Mac OSX specific
alias j='fasd_cd -d -i' # make it like autojump


# most used fast git commands
alias t="tig status"
alias tigs="tig status" #old habits don't die
alias d='git diff' 


###############
# Exports (custom)

export PATH=$PATH:$HOME/bin:/usr/local/bin:$GOBIN:/Applications/Racket\ v6.2/bin
export EDITOR="vim"

export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/fatih/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

# checkout `man ls` for the meaning
export LSCOLORS=cxBxhxDxfxhxhxhxhxcxcx

# enable GIT prompt color
export GIT_PS1_SHOWCOLORHINTS=true

###############
# Bash settings

# -- Prompt

# This is not used anymore as we use __git_ps1 for evaluatin the PS1, just here
# in case we might need it in the future
# PS1="\[$(tput setaf 6)\]\w\[$(tput sgr0)\]\[$(tput sgr0)\] \$ "

# 1. Git branch is being showed
# 2. Title of terminal is changed for each new shell
# 3. History is appended each time
export PROMPT_COMMAND='__git_ps1 "\[$(tput setaf 6)\]\w\[$(tput sgr0)\]\[$(tput sgr0)\]" " "; echo -ne "\033]0;$PWD\007"'


# -- History

# ignoreboth ignores commands starting with a space and duplicates. Erasedups
# removes all previous dups in history
export HISTCONTROL=ignoreboth:erasedups  
export HISTFILE=~/.bash_history          # be explicit about file path
export HISTSIZE=100000                   # in memory history size
export HISTFILESIZE=100000               # on disk history size
export HISTTIMEFORMAT='%F %T '
shopt -s histappend # append to history, don't overwrite it
shopt -s cmdhist    # save multi line commands as one command

# -- Completion


bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind "set completion-ignore-case on" # note: bind used instead of sticking these in .inputrc
bind "set bell-style none" # no bell
bind "set show-all-if-ambiguous On" # show list automatically, without double tab
# bind "TAB: menu-complete" # TAB syle completion

# -- Functions

# extracts the given file
x () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# -- Misc

# Colored man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# check windows size if windows is resized
shopt -s checkwinsize

# autocorrect directory if mispelled
#shopt -s dirspell direxpand

# auto cd if only the directory name is given
#shopt -s autocd

#use extra globing features. See man bash, search extglob.
shopt -s extglob

#include .files when globbing.
shopt -s dotglob
