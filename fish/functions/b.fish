# Defined in - @ line 1
function b --wraps='git branch' --description 'alias b=git branch'
  git branch $argv;
end
