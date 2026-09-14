---
name: commit-message
description: Use when writing the first commit on a branch named like feat/fix/hotfix/test followed by a ticket number (e.g. crm-3434), to decide the commit scope and format
---

# Commit Message

## Overview

Commit message format for ticket-based branches.

## When to Use

- The current branch follows the pattern `type/TICKET-1234-...` (`feat`, `fix`, `hotfix`, `test`, etc.)
- Writing the first commit on that branch

## Format

- If the branch name includes a ticket number, use it as the scope: `feat(crm-3434): add contact filter`
- If there's no ticket number, omit the scope entirely: `feat: add contact filter`
- Keep the message short
- Never include any Claude/AI trace (no `Co-Authored-By: Claude`, no tool signatures)
