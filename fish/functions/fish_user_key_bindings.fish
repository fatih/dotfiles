function fish_user_key_bindings
  fzf_key_bindings
  bind --erase \ct  # Disable ctrl+t for FZF, use it for terminal toggle in Cursor

  # Re-bind Ctrl+R to atuin after fzf_key_bindings overwrites it
  bind \cr _atuin_search
  bind -M insert \cr _atuin_search
end
