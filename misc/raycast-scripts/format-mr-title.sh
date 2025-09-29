#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Format MR Title
# @raycast.mode silent
# @raycast.icon 📝
# @raycast.packageName Formatter

# Get clipboard content
input=$(pbpaste)

# Transform it using perl
output=$(echo "$input" | perl -pe '
    s/^Draft: ?/[DRAFT]/i;
    s/Fix\//[FIX]/i;
    s/crm[- ]?(\d+)/[CRM-$1]:/i;
    s/(: )([a-z])/$1\u$2/;
')

# Put it back in clipboard
echo -n "$output" | pbcopy

echo "Formatted: $output"