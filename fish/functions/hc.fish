# Defined in - @ line 1
function hc --wraps='gh pr view --web' --description 'alias hc=gh pr view --web'
  gh pr view --web $argv;
end
