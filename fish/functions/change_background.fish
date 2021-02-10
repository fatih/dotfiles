function change_background --argument mode_setting
  # change background to the given mode. If mode is missing, 
  # we try to deduct it from the system settings.

  set -l mode "light" # default value
  if test -z $mode_setting
    set -l val (defaults read -g AppleInterfaceStyle) >/dev/null
    if test $status -eq 0
      set mode "dark"
    end
  else
    switch $mode_setting
      case light
        osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = false" >/dev/null
        set mode "light"
      case dark
        osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = true" >/dev/null
        set mode "dark"
    end
  end

  # well, seems like there is no proper way to send a command to 
  # Vim as a client. Luckily we're using tmux, which means we can 
  # iterate over all vim sessions and change the background ourself.
  set -l tmux_wins (/usr/local/bin/tmux list-windows -t main)

  for wix in (/usr/local/bin/tmux list-windows -t main -F 'main:#{window_index}')
    for pix in (/usr/local/bin/tmux list-panes -F 'main:#{window_index}.#{pane_index}' -t $wix)
      set -l is_vim "ps -o state= -o comm= -t '#{pane_tty}'  | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?\$'"
      /usr/local/bin/tmux if-shell -t "$pix" "$is_vim" "send-keys -t $pix escape ENTER"
      /usr/local/bin/tmux if-shell -t "$pix" "$is_vim" "send-keys -t $pix ':call ChangeBackground()' ENTER"
    end
  end

  # change tmux
  switch $mode
    case dark
      tmux source-file ~/.tmux/tmux-dark.conf
    case light
      tmux source-file ~/.tmux/tmux-light.conf
  end

  # change alacritty
  switch $mode
    case dark
      alacritty-theme gruvbox_dark
    case light
      alacritty-theme gruvbox_light
  end
end
