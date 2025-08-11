#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract information from JSON
model_name=$(echo "$input" | jq -r '.model.display_name')
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')

# Get directory name (basename)
dir_name=$(basename "$current_dir")

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

# Change to the current directory to get git info
cd "$current_dir" 2>/dev/null || cd /

# Get git branch
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    branch=$(git branch --show-current 2>/dev/null || echo "detached")
    
    # Get git status with file counts
    status_output=$(git status --porcelain 2>/dev/null)
    
    if [ -n "$status_output" ]; then
        # Count total files changed (any type of change)
        total_files=$(echo "$status_output" | wc -l | xargs)
        
        # Get detailed diff statistics for working directory changes
        working_stats=$(git diff --numstat HEAD 2>/dev/null)
        staged_stats=$(git diff --cached --numstat 2>/dev/null)
        
        # Calculate totals from both working and staged changes
        all_stats=$(printf "%s\n%s" "$working_stats" "$staged_stats" | awk '
        NF == 3 {
            added += $1
            removed += $2
            # Count lines that are modifications (files with both additions and removals)
            if ($1 > 0 && $2 > 0) {
                modified += ($1 < $2 ? $1 : $2)  # Take the smaller of additions/removals as modifications
                pure_added += ($1 > $2 ? $1 - $2 : 0)  # Remaining additions after accounting for modifications
                pure_removed += ($2 > $1 ? $2 - $1 : 0) # Remaining removals after accounting for modifications
            } else if ($1 > 0) {
                pure_added += $1
            } else if ($2 > 0) {
                pure_removed += $2
            }
        }
        END {
            printf "%d %d %d", pure_added+0, modified+0, pure_removed+0
        }')
        
        total_added=$(echo $all_stats | cut -d' ' -f1)
        total_modified=$(echo $all_stats | cut -d' ' -f2)
        total_removed=$(echo $all_stats | cut -d' ' -f3)
        
        # Build the new format: (branch | X files changed +additions ~modifications -deletions)
        git_info=" ${YELLOW}($branch${NC} ${YELLOW}|${NC} ${GRAY}${total_files} files changed${NC}"
        
        # Add line changes with appropriate colors and prefixes
        if [ "$total_added" -gt 0 ]; then
            git_info="${git_info} ${GREEN}+${total_added}${NC}"
        fi
        if [ "$total_modified" -gt 0 ]; then
            git_info="${git_info} ${YELLOW}~${total_modified}${NC}"
        fi
        if [ "$total_removed" -gt 0 ]; then
            git_info="${git_info} ${RED}-${total_removed}${NC}"
        fi
        
        git_info="${git_info} ${YELLOW})${NC}"
    else
        git_info=" ${YELLOW}($branch)${NC}"
    fi
else
    git_info=""
fi

# Output the status line
echo -e "${BLUE}${dir_name}${NC} ${CYAN}${model_name}${NC}${git_info}"