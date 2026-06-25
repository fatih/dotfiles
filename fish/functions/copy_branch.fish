function copy_branch --description 'Copy current git branch name to clipboard'
    set -l branch (git_branch_name)
    test -n "$branch"; and printf '%s' $branch | pbcopy
end
