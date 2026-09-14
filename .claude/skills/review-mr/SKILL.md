---
name: review-mr
description: Use when reviewing a merge request or pull request, to decide the process, what to check, and what to ignore
---

# Review MR

## Overview

Review process for merge requests, done as a back-and-forth between the reviewer and Claude — both read the MR independently.

## Steps

1. Run the code locally and test the functionality — if it doesn't work, there's no point reviewing further, say so
2. Check the ticket description against the MR: does what was implemented actually match the ticket's requirements? Point out anything the ticket asked for that's missing from the MR
3. Read the MR diff line by line, independently from the reviewer, to understand what's being introduced
4. Ask clarifying questions about anything that isn't obvious — on either side
5. When asked "is everything okay?", give a direct answer based on the above

## What to Ignore

- The "Reviewer" field/column in the GitLab MR
- GitLab MR template checklists — don't flag these as missing or incomplete
