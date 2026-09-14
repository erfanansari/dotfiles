---
name: package-update
description: Use when updating project dependencies (npm/pnpm packages) interactively, to decide what commands to run, when to check release notes, and what to verify after each step
---

# Package Update

## Overview

Interactive, staged dependency update — one category at a time, verifying between each. `pn` is the user's alias for `pnpm`.

## Categories (in order)

1. Dev dependencies — non-breaking patch
2. Dev dependencies — non-breaking minor
3. Dev dependencies — breaking major
4. Dependencies — non-breaking patch
5. Dependencies — non-breaking minor
6. Dependencies — breaking major

## Per-category flow

1. Run `pn outdated` to see what's available
2. Run `pn update -i` (interactive), scoped with `-D`/`--dev` for the dev-dependency categories, adding `--latest` for the breaking/major categories — the user picks which packages to bump
3. Split unrelated packages into separate commits; group related ones together (e.g. all eslint packages in one commit)
4. Remove `overrides`/`resolutions`, run `pn clean`, and recheck that none remain

## When the user says "do" / "go again" / "check"

That means the interactive update for the current category just happened — verify it before moving on:

1. Read `package.json` (and lockfile diff) to see exactly what changed
2. For each changed package, fetch its release notes, GitHub issues, and official docs covering the version range bumped
3. List any breaking changes and the actions they require
4. Update the codebase for those breaking changes
5. Report back, then move to the next category
