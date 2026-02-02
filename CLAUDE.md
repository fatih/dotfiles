# CLAUDE.md

## Fetching GitHub Content

IMPORTANT: Do NOT use WebFetch or direct HTTP requests for GitHub URLs. Private repositories will return 404 errors.

Use the `gh` CLI tool instead (it's authenticated locally):

- Issues: `gh issue view <url> --comments`
- PRs: `gh pr view <url> --comments`
- Files: `gh api repos/{owner}/{repo}/contents/{path}?ref={branch} --jq '.content' | base64 -d`
- API: `gh api repos/{owner}/{repo}/issues/{number}`

The `gh` CLI has OAuth tokens with access to private repos. Direct HTTP requests are unauthenticated.
