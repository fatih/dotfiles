function fish_title
    # Fish automatically calls this function and sends the result to the terminal
    # via OSC escape sequences. Ghostty (and other terminals) respect these
    # sequences to update the tab/window title dynamically.
    #
    # Shows the git root directory name when in a git repo,
    # falls back to current directory name otherwise.
    set -l git_root (git rev-parse --show-toplevel 2>/dev/null)
    if test -n "$git_root"
        basename "$git_root"
    else
        basename "$PWD"
    end
end
