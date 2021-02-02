function git_branch_name
  set -l dir $PWD/
  while test -n "$dir"
    set dir (string split -r -m1 / $dir)[1]
    if test -f "$dir/.git/HEAD"; and read -l git_head <"$dir/.git/HEAD"
      if set -l branch_name (string match -r '^ref: refs/heads/(.+)|([0-9a-f]{7})[0-9a-f]+$' $git_head)
        echo $branch_name[2]
      end
      return
    end
  end
end
