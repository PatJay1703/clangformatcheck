#!/bin/bash

# Usage: ./clang_tidy_checker.sh <PR_NUMBER> [clang-tidy args]

if [ $# -lt 1 ]; then
  echo "Usage: $0 <PR_NUMBER> [clang-tidy args]"
  exit 1
fi

PR_NUMBER=$1
shift

BASE_BRANCH="main"  # Adjust if your base is something else
PR_BRANCH="pr-$PR_NUMBER"

# Fetch PR branch (from GitHub-style PR refs)
echo "Fetching PR #$PR_NUMBER..."
git fetch origin pull/$PR_NUMBER/head:$PR_BRANCH

if [ $? -ne 0 ]; then
  echo "Error: Failed to fetch PR #$PR_NUMBER"
  exit 1
fi

# Get the diff between base branch and PR branch
DIFF=$(git diff $BASE_BRANCH...$PR_BRANCH -U0)

if [ -z "$DIFF" ]; then
  echo "No diff found between $BASE_BRANCH and $PR_BRANCH"
  exit 0
fi

if [ ! -f clang-tidy-diff.py ]; then
  echo "Error: clang-tidy-diff.py script not found."
  exit 1
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
