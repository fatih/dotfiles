function amp
    # Check if we're in a git repository
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo "Warning: amp must be called from within a git repository" >&2
        return 1
    end
    
    # Check if we're in the git root directory
    set git_root (git rev-parse --show-toplevel)
    set current_dir (pwd)
    
    if test "$git_root" != "$current_dir"
        echo "Warning: amp must be called from the git root directory ($git_root)" >&2
        return 1
    end
    
    # Call the original amp command
    command amp $argv
end
