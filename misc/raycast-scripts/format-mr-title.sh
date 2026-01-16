#!/bin/bash
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Format MR Title
# @raycast.mode silent
# @raycast.icon 📝
# @raycast.packageName GitLab Tools

# Get clipboard content
input=$(pbpaste)

# Transform it using perl
output=$(echo "$input" | perl -pe '
    s/^Draft: ?//i;                                      # Remove existing Draft: prefix
    s/^(\w+)\(crm[- ]?(\d+)\):/[\U$1\E][CRM-$2]:/i;     # Handle type(crm-123): format
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
    s/(?<!\[)crm[- ]?(\d+)/[CRM-$1]:/i;                 # Handle standalone crm-123 (not already in brackets)
    s/^(?!\[DRAFT\])/[DRAFT]/;                          # Add [DRAFT] at beginning if not present
    s/(: )([a-z])/$1\u$2/;                              # Capitalize first letter after ": "
')

# Type it at cursor position using AppleScript
osascript -e "tell application \"System Events\" to keystroke \"$output\""
echo "✅ Typed: $output"