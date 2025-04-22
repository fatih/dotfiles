function d -d "Fuzzy-find and cd a directory"
  cd (find . -type d | fzf --height 40% --info inline --border --reverse)
end
