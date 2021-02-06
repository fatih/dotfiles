function change_background --argument mode
  for pid in (pgrep vim)
    # vim automatically reloads changes the background once it receives a SIGUSR1
    kill -SIGUSR1 $pid
  end


  set -l mode (defaults read -g AppleInterfaceStyle) >/dev/null
  if test $status -eq 0
        alacritty-theme gruvbox_dark
  else
        alacritty-theme gruvbox_light
  end

  # todo: TMUX colors
  # todo: Airline/statusline colors
end
