#!/bin/bash

# Usage: ./clang-tidy-pr.sh <PR_NUMBER> [clang-tidy args]

if [ $# -lt 1 ]; then
  echo "Usage: $0 <PR_NUMBER> [clang-tidy args]"
  exit 1
fi

PR_NUMBER=$1
shift

if ! command -v gh &> /dev/null; then
  echo "Error: GitHub CLI (gh) is required but not installed."
  exit 1
fi

if [ ! -f clang-tidy-diff.py ]; then
  echo "Error: clang-tidy-diff.py script not found."
  exit 1
fi

echo "Fetching diff for PR #$PR_NUMBER..."
DIFF=$(gh pr diff "$PR_NUMBER" --diff)

if [ -z "$DIFF" ]; then
  echo "No diff found for PR #$PR_NUMBER"
  exit 0
fi

echo "Running clang-tidy on modified lines..."
OUTPUT=$(echo "$DIFF" | python3 clang-tidy-diff.py -p1 "$@" 2>&1)

if [ $? -ne 0 ]; then
  echo "clang-tidy encountered an error:"
  echo "$OUTPUT"
  exit 1
fi

echo "$OUTPUT"
echo "✅ clang-tidy check completed for modified lines in PR #$PR_NUMBER."
