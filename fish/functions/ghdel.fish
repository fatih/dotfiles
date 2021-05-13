function ghdel 
  co
  for i in (git branch | grep fatih); 
	  git br -D (string trim $i)
  end
end
