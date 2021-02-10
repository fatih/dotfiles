# Defined in - @ line 1
function sq --wraps='git rebase -i (git merge-base (git rev-parse --abbrev-ref HEAD) (basename (git symbolic-ref refs/remotes/origin/HEAD)))' --description 'alias sq=git rebase -i (git merge-base (git rev-parse --abbrev-ref HEAD) (basename (git symbolic-ref refs/remotes/origin/HEAD)))'
  git rebase -i (git merge-base (git rev-parse --abbrev-ref HEAD) (basename (git symbolic-ref refs/remotes/origin/HEAD))) $argv;
end
