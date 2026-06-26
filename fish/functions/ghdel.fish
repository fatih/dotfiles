# ghdel — delete local fatih/* branches whose PR has been merged.
#
# Switches to the default branch first, then for each local branch matching
# "fatih" it asks GitHub for the branch's PR state and only deletes the branch
# if that PR is MERGED. Branches with an open PR, a closed-but-unmerged PR, or
# no PR at all are left alone and reported, so abandoned/in-progress work is
# never force-deleted. Worktrees are not touched.
function ghdel --description 'Delete local fatih/* branches whose PR is merged'
    co

    set -l branches (git for-each-ref --format='%(refname:short)' refs/heads/ | grep fatih)
    if test -z "$branches"
        echo "ghdel: no fatih/* branches found"
        return
    end

    for branch in $branches
        set -l state (gh pr view $branch --json state --jq '.state' 2>/dev/null)

        switch "$state"
            case MERGED
                git branch -D $branch
            case ''
                echo "ghdel: skip $branch (no PR found)"
            case '*'
                echo "ghdel: skip $branch (PR $state)"
        end
    end
end
