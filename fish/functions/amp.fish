function amp
    # Check if we're in a git repository
    if git rev-parse --git-dir >/dev/null 2>&1
        # Get git root directory
        set git_root (git rev-parse --show-toplevel)
        set current_dir (pwd)
        
        # If not in git root, navigate there
        if test "$git_root" != "$current_dir"
            cd "$git_root"
            echo "Navigated to git root: $git_root"
        end
    end
    
    # Call the original amp command with --ide flag
    command amp --ide $argv
end
