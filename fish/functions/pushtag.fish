function pushtag --argument ver --argument comment
  if test -z "$ver"
    echo "Usage: pushtag [version] [comment]"
    return
  end

  if test -z "$comment"
    echo "Usage: pushtag [version] [comment]"
    return
  end

  co
  po

  git tag -a $ver -m $comment 
  git push origin $ver
end
