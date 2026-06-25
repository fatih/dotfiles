function copy_commandline --description 'Copy current command-line buffer to clipboard'
    set -l buf (commandline | string collect)
    printf '%s' "$buf" | pbcopy
    _copy_feedback 'command line' "$buf"
end
