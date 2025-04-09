#!/bin/bash

# Usage: ./clang-tidy-pr.sh <PR_NUMBER> [clang-tidy args]

# Check if PR number is provided
if [ $# -lt 1 ]; then
  echo "Usage: $0 <PR_NUMBER> [clang-tidy args]"
  exit 1
fi

PR_NUMBER=$1
shift

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
  echo "Error: GitHub CLI (gh) is required but not installed."
  exit 1
fi

# Fetch the diff of the PR
echo "Fetching diff for PR #$PR_NUMBER..."
DIFF=$(gh pr diff $PR_NUMBER --diff)

if [ -z "$DIFF" ]; then
  echo "No diff found for PR #$PR_NUMBER"
  exit 0
fi

# Check if clang-tidy-diff.py script is available
if [ ! -f clang-tidy-diff.py ]; then
  echo "Error: clang-tidy-diff.py script not found."
  exit 1
fi

# Run clang-tidy-diff.py on the diff and show output
echo "Running clang-tidy on modified lines..."
OUTPUT=$(echo "$DIFF" | python3 clang-tidy-diff.py -p1 "$@" 2>&1)

# Check if clang-tidy-diff.py ran successfully
if [ $? -ne 0 ]; then
  echo "clang-tidy encountered an error."
  echo "$OUTPUT"
  exit 1
fi

# Display the clang-tidy output
echo "$OUTPUT"
echo "clang-tidy check completed for modified lines in PR #$PR_NUMBER."

