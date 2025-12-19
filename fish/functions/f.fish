function f -d "Fuzzy-find and open a file with frecency ranking"
  # Determine the store path based on git root or current directory
  set -l git_root (git rev-parse --show-toplevel 2>/dev/null)
  set -l store_path

  if test -n "$git_root"
    # Use a hash of the git root for the store name
    set -l store_name (echo $git_root | md5 | cut -c1-12)
    set store_path "$HOME/.local/share/fre/$store_name.json"
  else
    # For non-git directories, use hash of current directory
    set -l store_name (pwd | md5 | cut -c1-12)
    set store_path "$HOME/.local/share/fre/$store_name.json"
  end

  # Ensure the fre directory exists
  mkdir -p "$HOME/.local/share/fre"

  # Get frecent files from fre (if store exists and has entries)
  set -l frecent_files
  if test -f "$store_path"
    set frecent_files (fre --store $store_path --sorted 2>/dev/null)
  end

  # Get all files from fd (respects .gitignore)
  set -l all_files (fd --type f --hidden --exclude .git 2>/dev/null)

  # Combine: frecent files first, then all files, remove duplicates
  set -l combined
  for file in $frecent_files
    # Only include if file still exists
    if test -f "$file"
      set -a combined $file
    end
  end
  for file in $all_files
    if not contains $file $combined
      set -a combined $file
    end
  end

  # Run fzf with no-sort to preserve frecency order
  set -l selected (printf '%s\n' $combined | fzf --height 40% --info inline --border --reverse --no-sort --preview 'cat {}')

  if test -n "$selected"
    # Record the selection to fre
    fre --store $store_path --add $selected
    # Open in nvim
    nvim $selected
  end
end
