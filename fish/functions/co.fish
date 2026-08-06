function co --wraps='git checkout' --description 'git checkout the default branch, or the branch/paths given'
    # With arguments, behave like plain `git checkout`.
    if test (count $argv) -gt 0
        git checkout $argv
        return
    end

    # No arguments: check out the remote's default branch.
    set -l default (git symbolic-ref --short --quiet refs/remotes/origin/HEAD | string replace -r '^origin/' '')

    # refs/remotes/origin/HEAD isn't set locally (e.g. repo wasn't cloned, or
    # the ref was never written). Ask origin what its default branch is.
    if test -z "$default"
        git remote set-head origin --auto >/dev/null 2>&1
        set default (git symbolic-ref --short --quiet refs/remotes/origin/HEAD | string replace -r '^origin/' '')
    end

    # Still nothing (offline, no remote): fall back to a local main/master.
    if test -z "$default"
        for b in main master
            if git show-ref --verify --quiet refs/heads/$b
                set default $b
                break
            end
        end
    end

    if test -z "$default"
        echo "co: could not determine the default branch" >&2
        return 1
    end

    git checkout $default
end
