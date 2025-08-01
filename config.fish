set -gxp PATH $HOME/go/bin $HOME/.local/bin /usr/local/opt/python@3.11/libexec/bin /usr/local/sbin /opt/homebrew/bin /opt/homebrew/opt/node@20/bin
set -gx GOBIN $HOME/go/bin
set -gx EDITOR nvim
set -gx FZF_CTRL_T_COMMAND nvim

# shell integration, if we don't set it, working directory features won't work
set -gx GHOSTTY_SHELL_INTEGRATION_XDG_DIR /Applications/Ghostty.app/Contents/Resources/ghostty/shell-integration

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
set -g __fish_git_prompt_color_branch cyan --dim 

# don't show any greetings
set fish_greeting ""

# don't describe the command for darwin
# https://github.com/fish-shell/fish-shell/issues/6270
function __fish_describe_command; end

# Senstive functions which are not pushed to Github
# It contains work related stuff, some functions, aliases etc...
source ~/.private.fish

set -g fish_user_paths "/usr/local/opt/openssl@1.1/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/mysql-client/bin" $fish_user_paths

# node, needed for developing my theme at arslan.io
set -gx LDFLAGS "-L/opt/homebrew/opt/node@20/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/node@20/include"


set -gx ATUIN_NOBIND "true"
status --is-interactive; atuin init fish | source

bind \cr _atuin_search
bind -M insert \cr _atuin_search

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/fatih/Code/google-cloud-sdk/path.fish.inc' ]; . '/Users/fatih/Code/google-cloud-sdk/path.fish.inc'; end

# status --is-interactive; and rbenv init - fish | source
