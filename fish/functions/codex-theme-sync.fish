function codex-theme-sync --description 'Resync tmux terminal colors for Codex after dark/light mode changes'
    if not set -q TMUX
        echo "Not in tmux. Run codex normally."
        return 0
    end

    set -l session (tmux display-message -p '#S' 2>/dev/null)
    if test -n "$session"
        echo "Detaching tmux client from session '$session' to refresh terminal colors."
    else
        echo "Detaching tmux client to refresh terminal colors."
    end

    echo "Reattach with: tmux attach"
    echo "Then run: codex"
    tmux detach-client
end
