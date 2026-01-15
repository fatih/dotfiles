# Generate Git title and description

Write a short title and description so I can use it for my Git Commit. Make it
short, and on point. Use markdown format to format especially code variables
and identifiers. Use at most three paragraphs, if you can use only a single
paragraph (depending on the amount of changes). It should be based on my latest
changes Also include the changes you did in the git repository. If there are no
changes, check my last commit's diff.

Do not include any tests changes. Do not commit it, display it and use pbcopy
to copy to my clipboard because I'm using macOS. While writing the title and
description, act like a principal software engineers that value simplicity over
complexity, write easy to understand texts. Do not use complex words.

The format should be in two sections (no headers), with titles "Problem" and
"Solution". If you don't know the Problem, ask me. Here is an example:

=========
Problem:

AWS's API call limit is 200. Using more than 200 requests causes the error:

"error": "describe : describe vpc endpoints: operation error EC2:
DescribeVPCEndpoints, https response error StatusCode: 400, RequestID:
a4643f0b-75b0-4597-83ed-0d1acff666ad, api error InvalidParameterValue: The
maximum number of filter values specified on a single call is 200",

Solution:

Decrease the number of filter values per call from 300 to 50.
=========
