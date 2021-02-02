# Defined in - @ line 1
function hb --wraps='gh repo view --web' --description 'alias hb=gh repo view --web'
  gh repo view --web $argv;
end
