function f -d "Fuzzy-find and open a file in current directory"
  nvim (fzf --height 40% --info inline --border --reverse --preview 'cat {}')
end
