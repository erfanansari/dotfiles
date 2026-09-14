---
name: commit-message
description: Use whenever writing a git commit message, to decide the format, scope, and keep it clean
---

# Commit Message

## Overview

Always applies when writing a commit message — keep it short and clean. On top of that, the first commit of a ticket-based branch also needs a scope.

## Format

- Always: keep the message minimal and not too long
- Always: no clutter — never include any Claude/AI trace (no `Co-Authored-By: Claude`, no tool signatures)
- If the current branch follows the pattern `type/TICKET-1234-...` (`feat`, `fix`, `hotfix`, `test`, etc.) and this is the first commit on that branch, use the ticket number as the scope: `feat(crm-3434): add contact filter`
- Otherwise, omit the scope entirely: `feat: add contact filter`
