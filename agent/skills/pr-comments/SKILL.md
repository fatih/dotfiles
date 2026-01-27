---
name: pr-comments
description: Fetches and displays all GitHub PR comments, review comments, and reviews for the current branch. Helps address PR feedback interactively. Use when the user mentions PR comments, PR feedback, review comments, addressing reviewer feedback, or checking PR reviews.
---

# PR Comments Review

Fetches all GitHub PR feedback for the current branch and presents it for interactive review and resolution.

## Quick Start

When the user wants to review PR feedback:

1. Run the fetch script: `scripts/fetch-pr-feedback.sh`
2. Parse the JSON output to extract all feedback
3. Present each comment/review to the user with context
4. For each item, ask: fix, skip, or get more context
5. If fixing, read the relevant file and make the changes

## Workflow

### Step 1: Fetch PR Feedback

Execute the script to get all PR data:

```bash
scripts/fetch-pr-feedback.sh
```

The script outputs JSON with:
- `pr`: PR number, title, URL
- `general_comments`: Top-level PR comments (bot comments filtered out)
- `review_comments`: Inline code review comments with file paths and line numbers
- `reviews`: Review summaries with state (APPROVED, CHANGES_REQUESTED, COMMENTED)

### Step 2: Handle No PR Case

If the script exits with error "No PR found for current branch":
- Inform the user: "No PR found for the current branch"
- Exit gracefully

### Step 3: Handle No Comments Case

If all arrays are empty:
- Inform the user: "PR found but no comments or reviews yet"
- Exit gracefully

### Step 4: Present Feedback

For each comment/review, display:

**General Comments:**
```
Author: @username
Type: General Comment
Body: [comment text]
URL: [link to comment]
```

**Review Comments (Inline):**
```
Author: @username
Type: Inline Review Comment
File: path/to/file.go
Line: 42
Body: [comment text]
URL: [link to comment]
```

**Reviews:**
```
Author: @username
Type: Review
State: CHANGES_REQUESTED | COMMENTED | APPROVED
Body: [review body if present]
Commit: abc123...
```

### Step 5: Interactive Resolution

For each item, ask the user:

1. **Fix this?** → Read the relevant file(s), understand context, make the requested change
2. **Skip?** → Move to next item
3. **More context?** → Show surrounding code, related files, or git history

When fixing:
- Read the file mentioned (or relevant files if general comment)
- Understand what the reviewer is asking for
- Make the change
- Continue to next item

### Step 6: Summary

After processing all feedback:
- Summarize what was fixed
- List items that were skipped
- Note any items that need follow-up

## Examples

**User says:** "Check my PR comments"
→ Run script, fetch feedback, present each item for resolution

**User says:** "Address the PR feedback"
→ Same workflow, focus on actionable items

**User says:** "What did reviewers say?"
→ Fetch and display all feedback in readable format

## Notes

- Bot comments (github-actions, etc.) are automatically filtered
- Review comments include file paths and line numbers for context
- Reviews show state to understand approval status
- Always read files before making changes to understand context
