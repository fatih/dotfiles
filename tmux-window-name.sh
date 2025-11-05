#!/bin/bash

# Get the git root directory name for tmux window naming
# Falls back to current directory name if not in a git repo

if git_root=$(git rev-parse --show-toplevel 2>/dev/null); then
    basename "$git_root"
else
    basename "$PWD"
fi
