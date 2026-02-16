---
name: git-message
description: Generates a git commit title and description without committing. Use when user asks for a commit message, git description, or wants to describe their changes. Outputs the message and copies it to clipboard using pbcopy.
---

# Generate Git Title and Description

Generate a commit message based on the latest changes without committing.

## Process

1. Check `git diff` for current changes
2. Sometimes the user has staged the changes, but not commited.
3. If no changes, check the last commit's diff and use that as baseline
4. Generate title and description
5. Display the message
6. Copy to clipboard using `pbcopy` (macOS)

## Commit Message Format

Write a short title and description. Use markdown to format code variables and identifiers.

### Title Format

Single word prefix, double colon, then what was done:

```
storage: fix AWS API call limit
```

### Body Format

Two sections (no headers):

1. **Problem:** - Describe the issue being solved. If unclear,  ask the user
2. **Solution:** - Describe how it was solved. 

Use at most three paragraphs (single paragraph if changes are small).

## Guidelines

- Keep it short and on point
- Use markdown to format code variables and identifiers
- Use at most three paragraphs (single paragraph if changes are small)
- Do NOT include test changes
- Write like a principal software engineer: simple, easy to understand, no complex words
- If the Problem is unclear, ask the user

## Example Output

```
storage: fix AWS API call limit

Problem:

AWS's API call limit is 200. Using more than 200 requests causes the error:

"error": "describe : describe vpc endpoints: operation error EC2:
DescribeVPCEndpoints, https response error StatusCode: 400, RequestID:
a4643f0b-75b0-4597-83ed-0d1acff666ad, api error InvalidParameterValue: The
maximum number of filter values specified on a single call is 200",

Solution:

Decrease the number of filter values per call from 300 to 50.
```
