function gam --wraps='git commit --amend' --description 'alias gam=git commit --amend'
  git commit --amend $argv
end
