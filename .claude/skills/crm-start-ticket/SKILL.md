---
name: crm-start-ticket
description: Use at the start of any CRM (crm-fe) Jira ticket, to create the correctly named branch from the right base before writing code
---

# CRM Start Ticket (branch)

## Overview

Step 1 of 2 for a crm-fe ticket. Turns a Jira ticket (`CRM-xxxx` + title) into a branch. Step 2 is `crm-open-mr`. Commit message format lives in the `commit` skill, do not duplicate it here.

## Branch name

```
<type>/crm-<id>-<kebab-case-of-the-jira-title>
```

- Lowercase the ticket id: `crm-3174`.
- Kebab-case the Jira title as written. Lowercase, strip punctuation (`:`, `/`, `'`, `,`), spaces to `-`. Do not truncate, long names are normal here.
- Keep prefixes like `FE:` from the title (they become `fe-`), do not rewrite the title.
- Example: `CRM-3174 "FE: Integrate PippoDrome with HW and JAFX Frontend"` becomes `feat/crm-3174-fe-integrate-pippodrome-with-hw-and-jafx-frontend`.

## Type

| Ticket is | type |
| --- | --- |
| new capability, integration, new UI | `feat` |
| bug, validation gap, broken behaviour | `fix` |
| deps, config, tooling, schema sync | `chore` |
| restructure without behaviour change | `refactor` |
| urgent prod fix or CVE | `hotfix` (lowercase) |
| tests only | `test` |
| pnpm/node/build tooling | `build` |

Only these lowercase types appear in the repo history. README mentions `hotFix`, ignore it.

## Base branch

- Default: `develop`.
- `release-24.0.0` only for the FE 24 line (RSC and server actions migration, auth rewrite, recaptcha runtime keys). If the ticket is not obviously part of that, ask which base before creating the branch.
- Stacked work (ticket depends on an unmerged branch) bases on that branch, rare.
- Do not base on your current branch unless it is the intended base.

## Steps

1. `git fetch origin`
2. If the working tree has unrelated uncommitted changes, do not stash or carry them over. Use a worktree instead and run `pnpm install` in it:
   `git worktree add --no-track -b <branch> ../crm-fe-<crm-id> origin/<base>`
   Otherwise: `git switch --no-track -c <branch> origin/<base>`
3. `--no-track` matters: without it the branch tracks `origin/develop` and a plain `git push` goes to the wrong place. Push later with `git push -u origin <branch>`.
4. A fresh worktree has no Next generated types, so `pn type-check` shows `PageProps` / `params` errors in `src/app/**`. They are not from your change, ignore them.
5. Confirm the branch name back to the user.

## Rules

- First commit of the branch carries the scope: `feat(crm-3174): ...` (see `commit` skill).
- Never commit or push unless the user says so in that turn.
- Admin endpoints get `/admin` automatically, do not add it.
- Use `pn` (pnpm alias) for all commands.
