function ghpr
	git push -u origin
	gh pr create --web --fill
end
