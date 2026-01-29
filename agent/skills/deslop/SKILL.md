---
name: deslop
description: Removes AI-generated code slop from the current branch. Use when user mentions deslop, cleaning up AI code, removing AI artifacts, fixing AI style issues, or making code more natural/human-like.
---

# Remove AI Code Slop

Check the diff against main and remove all AI-generated slop introduced in this branch.

## What to Remove

1. **Extra comments** - Comments a human wouldn't add or that are inconsistent with the rest of the file
2. **Defensive checks** - Abnormal defensive checks for that area of the codebase, especially if called by trusted/validated codepaths
3. **Type workarounds** - Casts to `any` to get around type issues
4. **Style inconsistencies** - Any style that doesn't match the file
5. **Verbose naming** - Simplify long variable names with smaller ones, as used in a proper, well-maintained Go project

## Process

1. Run `git diff main` to see all changes in the branch
2. Review each file for the slop patterns above
3. Make edits to remove the slop
4. Report a 1-3 sentence summary of what was changed
