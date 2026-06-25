function fish_user_key_bindings
  fzf_key_bindings
  bind --erase \ct  # Disable ctrl+t for FZF, use it for terminal toggle in Cursor

  # Re-bind Ctrl+R to atuin after fzf_key_bindings overwrites it
  bind \cr _atuin_search
  bind -M insert \cr _atuin_search

  # Hyper (⌘⌃⌥⇧) copy shortcuts. Ghostty translates the Hyper chord into
  # "\x1d (Ctrl+]) + letter" which passes through tmux to these bindings.
  # \x1d=^] leader, \x62=b \x64=d \x6c=l
  bind \x1d\x62 copy_branch          # Hyper+B → git branch
  bind \x1d\x64 copy_pwd             # Hyper+D → current directory
  bind \x1d\x6c copy_commandline     # Hyper+L → command-line buffer
  bind -M insert \x1d\x62 copy_branch
  bind -M insert \x1d\x64 copy_pwd
  bind -M insert \x1d\x6c copy_commandline
end
