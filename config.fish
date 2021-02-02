set -gxp PATH $HOME/go/bin
set -gx GOBIN $HOME/go/bin
set -gx EDITOR vim

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
set -gxp PATH /usr/local/opt/python@3.9/libexec/bin

# git prompt settings
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_char_stateseparator ' '
set -g __fish_git_prompt_char_dirtystate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_conflictedstate "+"
set -g __fish_git_prompt_color_dirtystate yellow
set -g __fish_git_prompt_color_cleanstate green --bold
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_branch cyan --dim --italics

# don't show any greetings
set fish_greeting ""

# brew install jump, https://github.com/gsamokovarov/jump
status --is-interactive; and source (jump shell fish | psub)

# Senstive functions which are not pushed to Github
# It contains work related stuff, some functions, aliases etc...
source ~/.config/fish/private.fish

