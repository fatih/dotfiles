# AGENTS.md

## Fetching GitHub Content

IMPORTANT: Do NOT use WebFetch or direct HTTP requests for GitHub URLs. Private repositories will return 404 errors.

Use the `gh` CLI tool instead (it's authenticated locally):

- Issues: `gh issue view <url> --comments`
- PRs: `gh pr view <url> --comments`
- Files: `gh api repos/{owner}/{repo}/contents/{path}?ref={branch} --jq '.content' | base64 -d`
- API: `gh api repos/{owner}/{repo}/issues/{number}`

The `gh` CLI has OAuth tokens with access to private repos. Direct HTTP requests are unauthenticated.

## Git Workflow

- Always use the `/commit` skill for committing changes. Never commit directly to main or use plain `git commit`. The `/commit` skill creates a feature branch and follows the proper workflow.
- When debugging or investigating issues, confirm the current branch and environment state before starting analysis.

## Environment

- Default shell is fish. Do not suggest switching to fish or investigate bash/zsh startup issues.

## Decision Tracking

- When I correct a design decision or explicitly abandon an approach, do NOT re-introduce it later. Track decisions that were rejected and never add back removed fields, annotations, or patterns without explicit approval.

## Code Changes

- Keep changes minimal and focused. Do not add optional parameters, overcomplicate models with unnecessary steps, or make fields optional unless explicitly asked.
- For error handling: always return errors rather than logging warnings for invalid/malformed data. Do not silently swallow errors or reset values to defaults on failure without explicit approval.lso
