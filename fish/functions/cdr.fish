# Defined in - @ line 1
function cdr --wraps='cd (git rev-parse --show-toplevel)' --description 'alias cdr=cd (git rev-parse --show-toplevel)'
  cd (git rev-parse --show-toplevel) $argv;
end
