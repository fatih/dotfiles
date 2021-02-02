function usego --argument ver
  if test -z "$ver"
    echo "Usage: usego [version]"
    return
  end

  set go_bin_path (command -v "go$ver")
  if test -z $go_bin_path
    echo "go $ver does not exist, downloading with commands: "
    echo "  go get golang.org/dl/go$ver"
    echo "  go$ver download"
    echo ""

    go get "golang.org/dl/go$ver"
    go$ver download
    set go_bin_path (command -v "go$ver")
  end

  echo "Switched to $go_bin_path"
  ln -sf $go_bin_path $GOBIN/go
end
