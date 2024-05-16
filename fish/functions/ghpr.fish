function ghpr
	git push -u origin
	gh pr create --web --template "pull_request_template.md"
end
