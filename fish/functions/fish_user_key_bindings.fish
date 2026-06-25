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

  # Same copies on Alt (left Option) — easier than Hyper on the MacBook keyboard.
  # macos-option-as-alt=left sends left-Option+key as \e+key straight to fish;
  # Turkish input uses the RIGHT Option (compose), so it is unaffected — and
  # b/d/l have no Turkish character anyway. These override the fish defaults
  # alt-b (backward-word), alt-d (kill-word), and alt-l (downcase-word).
  bind \eb copy_branch          # Alt+B → git branch
  bind \ed copy_pwd             # Alt+D → current directory
  bind \el copy_commandline     # Alt+L → command-line buffer
  bind -M insert \eb copy_branch
  bind -M insert \ed copy_pwd
  bind -M insert \el copy_commandline
end
