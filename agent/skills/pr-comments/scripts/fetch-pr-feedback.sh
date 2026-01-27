#!/bin/bash
# Fetch all GitHub PR feedback for the current branch
# Outputs JSON with general comments, review comments, and reviews

set -euo pipefail

# Get repo owner/name
REPO=$(gh repo view --json owner,name -q '.owner.login + "/" + .name')

# Check if PR exists for current branch
PR_JSON=$(gh pr view --json number,title,url,comments,reviews 2>/dev/null || echo "")

if [ -z "$PR_JSON" ] || [ "$PR_JSON" = "null" ]; then
  echo '{"error": "No PR found for current branch"}' >&2
  exit 1
fi

PR_NUMBER=$(echo "$PR_JSON" | jq -r '.number // empty')

if [ -z "$PR_NUMBER" ] || [ "$PR_NUMBER" = "null" ]; then
  echo '{"error": "No PR found for current branch"}' >&2
  exit 1
fi

# Fetch inline review comments (comments on code)
REVIEW_COMMENTS=$(gh api "repos/${REPO}/pulls/${PR_NUMBER}/comments" 2>/dev/null || echo "[]")

# Merge all data into single JSON
jq -n \
  --argjson pr_data "$PR_JSON" \
  --argjson review_comments "$REVIEW_COMMENTS" \
  '{
    pr: $pr_data | {number, title, url},
    general_comments: ($pr_data.comments // [] | map(select(.author.login != "github-actions[bot]" and (.author.login | test("\\[bot\\]$") | not)))),
    review_comments: $review_comments,
    reviews: ($pr_data.reviews // [] | map({author: .author.login, state, body, submittedAt, commit: .commit.oid}))
  }'
