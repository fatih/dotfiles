# Defined in - @ line 1
function tigs --wraps='tig status' --description 'alias tigs=tig status'
  tig status $argv;
end
