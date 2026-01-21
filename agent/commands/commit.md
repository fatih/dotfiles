# Commit changes

I want you to commit our changes. First if we're on the main or master branch,
create a new branch with a `fatih-` prefix. Example:
"fatih-fix-aws-rate-limit". If there is already a non-main branch, proceed.

Write a short title and description so we can use it for my Git Commit. Make it
short, and on point. Use markdown format to format especially code variables
and identifiers. Use at most three paragraphs, if you can use only a single
paragraph (depending on the amount of changes). 

Do not include any tests changes in your description, but make sure to git add
all files, never skip any change. While writing the title and description, act
like a principal software engineers that value simplicity over complexity,
write easy to understand texts. Do not use complex words.

The title should have a single word, that follows a double colon and then what
we did. The content format should be in two sections (no headers), with titles
"Problem" and "Solution". If you don't know the Problem, ask me. 

Here is an example git commit:

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
