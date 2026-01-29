---
name: commit
description: Commits changes with a well-formatted message. Use when user asks to commit, save changes, or create a git commit. Creates a new branch with fatih- prefix if on main/master, then commits with a structured title and Problem/Solution format.
---

# Commit Changes

Commit the current changes following this workflow. The changes are either not
staged yet, staged or already commited and part of the branch, which needs to
be diffed or checked:

## Branch Handling

1. If on `main` or `master`, create a new branch with `fatih-` prefix (e.g., `fatih-fix-aws-rate-limit`)
2. If already on a feature branch, proceed with commit

## Commit Message Format

Write a short title and description. Use markdown to format code variables and identifiers.

### Title Format

Single word prefix, double colon, then what was done:

```
storage: fix AWS API call limit
```

### Body Format

Two sections (no headers):

1. **Problem:** - Describe the issue being solved
2. **Solution:** - Describe how it was solved

Use at most three paragraphs (single paragraph if changes are small).

## Guidelines

- Do NOT include test changes in the description
- Git add ALL files that are related to the change, never skip any change. DO NOT ADD unrelevant files.
- Write like a principal software engineer: simple, easy to understand, no complex words
- If the Problem is unclear, ask the user

## Example

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
