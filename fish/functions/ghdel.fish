function ghdel 
  co
  for i in (git branch | grep rubinette); 
	  git br -D (string trim $i)
  end
end
