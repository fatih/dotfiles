#Like autojump but written in pure bash: https://github.com/rupa/z 
. `brew --prefix`/etc/profile.d/z.sh
alias j='z' #because I'm used to autojump

# Path to your oh-my-zsh installation.
export ZSH=/Users/fatih/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git gitfast)

# User configuration
source $ZSH/oh-my-zsh.sh

export GOPATH=$HOME/Code/go
export GOBIN=$HOME/Code/go/bin
export TERM="screen-256color"
export CDPATH=.:$GOPATH/src/github.com
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:$GOBIN"

alias ct="cd ~/Code/do/cthulhu"
alias cf="cd ~/Code/do/chef"
alias c="cd ~/Code"

alias vim='nvim'
alias vi='nvim'
alias tigs="tig status"
alias -s go="go run"


export CHEF_USER_NAME="farslan"

eval "$(direnv hook zsh)"
