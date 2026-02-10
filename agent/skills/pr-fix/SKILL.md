---
name: pr-fix
description: Fetches all PR comments and autonomously fixes actionable feedback with a test-fix loop. Use when user wants to address all PR feedback, fix PR comments, or resolve reviewer requests.
---

# PR Fix

Fetches all PR feedback, autonomously fixes every actionable comment, and validates with tests. Presents a summary for review before committing.

## Workflow

### Step 1: Fetch PR Feedback

Run the shared fetch script from pr-comments:

```bash
../pr-comments/scripts/fetch-pr-feedback.sh
```

If no PR or no comments, inform the user and exit.

### Step 2: Categorize Comments

For each comment, classify as:
- **Actionable**: Requires a code change (fix request, style issue, bug, refactor suggestion)
- **Discussion**: Requires a response or decision from the user, not a code change
- **Resolved**: Already addressed or outdated

### Step 3: Fix Each Actionable Comment

For each actionable comment:

1. Read the relevant file(s) to understand the full context
2. Understand what the reviewer is asking for
3. Implement the fix
4. If the fix is ambiguous or could go multiple ways, flag it for the summary instead of guessing

### Step 4: Validate

After all fixes are applied, run the project's test and lint commands. Check the project's CLAUDE.md, Makefile, or common conventions for the right commands. Common examples:

- `go test ./...` and `go vet ./...` for Go projects
- `make test` and `make lint` if a Makefile exists
- `npm test` for Node projects

If tests fail:
1. Analyze the failure
2. Fix it
3. Re-run tests
4. Repeat up to 5 times total. If still failing, stop and report the failure.

### Step 5: Summary

Present a summary table:

```
| # | PR Comment | What Changed | Files Modified | Tests |
|---|------------|--------------|----------------|-------|
| 1 | "use cmp.Or here" | Replaced if/else with cmp.Or | pkg/foo.go | pass |
| 2 | "missing error check" | Added error return | pkg/bar.go | pass |
```

Then list separately:
- **Discussion items**: Comments that need the user's input, not a code change
- **Skipped items**: Anything unclear or already resolved

### Step 6: Wait for Review

Do NOT commit. Let the user review the full diff first. If the user approves, use `/commit` to commit the changes.

## Notes

- Always read files before changing them
- Keep fixes minimal and focused on what the reviewer asked
- Do not make unrelated improvements or refactors
- If a reviewer comment conflicts with another, flag it instead of picking a side
