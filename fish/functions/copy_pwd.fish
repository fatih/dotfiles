function copy_pwd --description 'Copy current directory path to clipboard'
    printf '%s' "$PWD" | pbcopy
    _copy_feedback directory "$PWD"
end
