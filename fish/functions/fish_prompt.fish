function fish_prompt
    # Emit OSC 7 to report current directory to tmux (without hostname for simpler parsing)
    printf '\e]7;file://%s\a' (string escape --style=url $PWD)
    echo -n -s (set_color $fish_color_cwd --bold) (prompt_pwd)(set_color normal) (fish_git_prompt) " "
end
