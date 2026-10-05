---
name: crm-open-mr
description: Use after the first commit of a CRM (crm-fe) ticket branch is pushed, to open the GitLab draft MR with the right title, template and labels via glab
---

# CRM Open MR

## Overview

Step 2 of 2 (step 1 is `crm-start-ticket`). Opens a draft MR on GitLab with `glab`. Keep it minimal: template picked by ticket type, draft, `In Progress` label. Do not fill checklists, notes, PID or test environment, the team does not care.

## Preconditions

- Branch is pushed and has at least one commit ahead of the base (`git push -u origin <branch>`, only when the user asked to push).
- Use `glab` for everything on GitLab, never web fetch.

## Title

```
[DRAFT][<TYPE>][CRM-<id>]: <Jira title, sentence case, no "FE:" prefix>
```

- `[DRAFT]` in the title is what makes GitLab treat it as draft (verified on existing MRs). No need to pass `--draft`.
- TYPE is the branch type uppercased: `FEAT FIX CHORE REFACTOR HOTFIX TEST BUILD`.
- Example: `[DRAFT][FEAT][CRM-3174]: Integrate PippoDrome with HW and JAFX Frontend`.
- When the ticket leaves draft, drop `[DRAFT]` from the title.

## Template and labels

| Branch type | Template (`.gitlab/merge_request_templates/`) | Type label |
| --- | --- | --- |
| feat | `Feature` | `Feature` |
| fix | `Bugfix` | `Fix` |
| chore | `Chore` | `Chore` |
| refactor | `Refactor` | `Internal Refactor` |
| hotfix | `Hotfix` | `Hotfix` |
| test | `Refactor` | `Internal Refactor` |
| build | none | `Build` |

Always add `In Progress`. Add when true: `Business Requirement` (ticket comes from product or business, most feat/fix MRs), `Backend Dependent` (blocked on a BE change), `DevOps Dependent`. Labels must already exist in the project, do not invent new ones.

## Command

Run from the branch checkout. Replace `CRM-XXXX` in the template with the ticket id and nothing else:

```bash
glab mr create \
  --source-branch "$BRANCH" --target-branch "$BASE" \
  --title "[DRAFT][FEAT][CRM-3174]: Integrate PippoDrome with HW and JAFX Frontend" \
  --description "$(sed 's/CRM-XXXX/CRM-3174/' .gitlab/merge_request_templates/Feature.md)" \
  --label "Feature,In Progress,Business Requirement" \
  --assignee erfans --remove-source-branch --yes
```

- Target is the same base the branch was cut from (`develop` by default, `release-24.0.0` for the FE 24 line).
- Assignee is the author (`erfans`). No reviewer, no milestone, no squash (project default stays).
- Do not pass `--template` together with `--description`, the sed above already expands the template. Skip the description for `build`.
- Verify afterwards: `glab mr view <iid>` shows the title, labels and assignee, and `draft` is true.

## Later lifecycle (reference only)

Teammates move labels as the MR progresses: `In Progress` then `Code Review`, `On FE-QA`, `Verified by FE-QA`, `On Arringo-QA`, `Verified by Arringo-QA`, `Ready to Merge`. Only touch these when the user asks.

## Rules

- Output the MR URL to the user, nothing more.
- Never mention Claude/AI in the title or description. The MR body is only the template.
- Do not enable auto-merge.
