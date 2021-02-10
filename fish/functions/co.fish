# Defined in - @ line 1
function co --wraps='git checkout (basename (git symbolic-ref refs/remotes/origin/HEAD))' --description 'alias co=git checkout (basename (git symbolic-ref refs/remotes/origin/HEAD))'
  git checkout (basename (git symbolic-ref refs/remotes/origin/HEAD)) $argv;
end
