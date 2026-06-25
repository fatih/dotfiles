function copy_commandline --description 'Copy current command-line buffer to clipboard'
    commandline | string collect | pbcopy
end
