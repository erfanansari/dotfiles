---
name: package-update
description: Use when updating project dependencies (npm/pnpm packages), to decide ordering, grouping, and verification steps
---

# Package Update

## Overview

Go in steps, not all at once — update dependencies in order of increasing risk, verifying between each step.

## Steps (in order)

1. Dev dependencies — non-breaking patch
2. Dev dependencies — non-breaking minor
3. Dev dependencies — breaking major
4. Dependencies — non-breaking patch
5. Dependencies — non-breaking minor
6. Dependencies — breaking major

## Guidelines

- Split unrelated packages into separate commits; group related ones together (e.g. all eslint packages in one commit)
- Remove `overrides`, run `pn clean`, and recheck that no overrides remain
- After each step, review the terminal output/diff for breaking changes or required follow-up actions before moving to the next step
