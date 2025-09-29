#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Format MR Title
# @raycast.mode silent
# @raycast.icon 📝
# @raycast.packageName GitLab Tools

# Get clipboard content
input=$(pbpaste)

# Transform it using perl - handles Fix, Feat, Feature, Chore, etc.
output=$(echo "$input" | perl -pe '
    s/^Draft: ?/[DRAFT]/i;
    s/Fix\//[FIX]/i;
    s/Feat(ure)?\//[FEAT]/i;
    s/Chore\//[CHORE]/i;
    s/Refactor\//[REFACTOR]/i;
    s/Docs\//[DOCS]/i;
    s/Test\//[TEST]/i;
    s/Style\//[STYLE]/i;
    s/Perf\//[PERF]/i;
    s/Build\//[BUILD]/i;
    s/CI\//[CI]/i;
    s/crm[- ]?(\d+)/[CRM-$1]:/i;
    s/(: )([a-z])/$1\u$2/;
')

# Type it at cursor position using AppleScript
osascript -e "tell application \"System Events\" to keystroke \"$output\""

echo "✅ Typed: $output"