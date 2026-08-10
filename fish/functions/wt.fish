# wt — switch to another git worktree checkout
#
# Git can have multiple working directories for one repo (worktrees). Each
# worktree is a separate folder with its own branch checked out — e.g. main at
# ~/src/my-repo and a Cursor agent branch at
# ~/.cursor/worktrees/my-repo/ogum. You cannot `git checkout` a branch
# that is already checked out elsewhere; you cd into that worktree instead.
#
# This function finds the right directory and cd's there. That is all it does,
# plus optional helpers (fzf picker, list, open Cursor). It does not create,
# remove, or modify worktrees.
#
# Works from any directory inside the repo (including an existing worktree).
#
# Usage:
#   wt                  fzf picker (branch + path)
#   wt main             jump by branch name
#   wt fatih/1a09116d   exact branch match
#   wt ogum             partial match on path or branch
#   wt --list           show `git worktree list`
#   wt -c ogum          cd into worktree and open Cursor there
#
function wt --description 'cd into a git worktree (fuzzy or by branch/path)'
    argparse -n wt c/cursor l/list -- $argv
    or return

    set -l repo_root (git rev-parse --show-toplevel 2>/dev/null)
    if test -z "$repo_root"
        echo "wt: not inside a git repository" >&2
        return 1
    end

    if set -q _flag_list
        git -C "$repo_root" worktree list
        return
    end

    set -l path
    if test (count $argv) -gt 0
        set path (_wt_resolve_path "$repo_root" $argv[1])
        if test -z "$path"
            echo "wt: no worktree matching '$argv[1]'" >&2
            return 1
        end
    else
        set -l selected (
            git -C "$repo_root" worktree list | awk '{
                path = $1
                branch = "(detached)"
                if (match($0, /\[[^]]+\]/)) {
                    branch = substr($0, RSTART + 1, RLENGTH - 2)
                }
                printf "%s\t%s\n", branch, path
            }' | fzf --height 40% --info inline --border --reverse \
                --delimiter='\t' --with-nth=1,2 \
                --preview 'echo {2}' --preview-window=down:1
        )
        if test -z "$selected"
            return 1
        end
        set path (string split \t -- $selected)[2]
    end

    if not test -d "$path"
        echo "wt: directory does not exist: $path" >&2
        return 1
    end

    cd "$path"

    if set -q _flag_cursor
        command cursor .
    end
end

function _wt_resolve_path --argument repo_root query
    set -l partial

    for line in (git -C "$repo_root" worktree list)
        set -l path (string split ' ' -- $line)[1]
        set -l branch (_wt_branch_from_line $line)

        if test "$branch" = "$query"
            echo $path
            return
        end

        if string match -q "*$query*" -- $branch; or string match -q "*$query*" -- $path
            set -a partial $path
        end
    end

    if test (count $partial) -eq 1
        echo $partial[1]
    else if test (count $partial) -gt 1
        echo "wt: ambiguous match for '$query':" >&2
        for p in $partial
            echo "  $p" >&2
        end
        return 1
    end
end

function _wt_branch_from_line --argument line
    set -l matches (string match -r '\[([^\]]+)\]' -- $line)
    if test (count $matches) -gt 1
        echo $matches[2]
    else
        echo "(detached)"
    end
end
