function change_background --argument mode_setting
  # change background to the given mode. If mode is missing, 
  # we try to deduct it from the system settings.
  #

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

  # vim automatically reloads changes the background once it receives a SIGUSR1
  for pid in (pgrep vim)
    kill -SIGUSR1 $pid
  end

  # change alacritty
  switch $mode
    case dark
      alacritty-theme gruvbox_dark
    case light
      alacritty-theme gruvbox_light
  end

  # todo: TMUX colors
end
