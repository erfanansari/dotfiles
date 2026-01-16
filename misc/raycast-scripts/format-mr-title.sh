#!/bin/bash
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Format MR Title
# @raycast.mode silent
# @raycast.icon 📝
# @raycast.packageName GitLab Tools

# Copy and immediately read (no wait)
osascript -e 'tell application "System Events" to keystroke "c" using command down'
input=$(pbpaste)

# Transform
output=$(echo "$input" | perl -pe '
    s/^Draft: ?//i;
    s/^(\w+)\(crm[- ]?(\d+)\):/[\U$1\E][CRM-$2]:/i;
    s/^Fix\//[FIX]/i;
    s/^Hotfix\//[HOTFIX]/i;
    s/^Feat(ure)?\//[FEAT]/i;
    s/^Chore\//[CHORE]/i;
    s/^Refactor\//[REFACTOR]/i;
    s/^Docs\//[DOCS]/i;
    s/^Test\//[TEST]/i;
    s/^Style\//[STYLE]/i;
    s/^Perf\//[PERF]/i;
    s/^Build\//[BUILD]/i;
    s/^CI\//[CI]/i;
    s/(?<!\[)crm[- ]?(\d+)/[CRM-$1]:/i;
    s/^(?!\[DRAFT\])/[DRAFT]/;
    s/(: )([a-z])/$1\u$2/;
')

# Type replacement
osascript -e "tell application \"System Events\" to keystroke \"$output\""