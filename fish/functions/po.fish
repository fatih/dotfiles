# Defined in - @ line 1
function po --wraps='git pull origin (git rev-parse --abbrev-ref HEAD)' --description 'alias po=git pull origin (git rev-parse --abbrev-ref HEAD)'
  git pull origin (git rev-parse --abbrev-ref HEAD) $argv;
end
