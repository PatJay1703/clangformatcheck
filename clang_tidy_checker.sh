#!/bin/bash

# Usage: ./clang_tidy_pr.sh <pr_number> [base_branch]
# Example: ./clang_tidy_pr.sh 123 main

pr_number=$1
base_branch=${2:-main}

# Check if PR number is provided
if [ -z "$pr_number" ]; then
    echo -e "\033[1;31m❌ Usage: $0 <pr_number> [base_branch]\033[0m"
    exit 1
fi

pr_branch="pr-$pr_number"

echo -e "\033[1;34m📥 Fetching PR #$pr_number...\033[0m"
git fetch origin pull/$pr_number/head:$pr_branch || { echo -e "\033[1;31m❌ Failed to fetch PR\033[0m"; exit 1; }

# Define extensions to check
extensions="c|cpp|cc|cxx|java|js|json|m|h|proto|cs"

echo -e "\033[1;36m🔍 Finding files modified between $base_branch and $pr_branch...\033[0m"
modified_files=$(git diff --name-only $base_branch $pr_branch | grep -E "\.(${extensions})$")

if [ -z "$modified_files" ]; then
    echo -e "\033[1;32m✅ No relevant files modified in this PR.\033[0m"
    exit 0
fi

echo -e "\033[1;33m📂 Modified files:\033[0m"
echo "$modified_files"

# Checkout to the PR branch
git checkout $pr_branch >/dev/null

# Fetch the diff of modified lines
echo -e "\033[1;34m📂 Fetching diff for modified lines...\033[0m"
DIFF=$(git diff $base_branch $pr_branch -- $modified_files)

if [ -z "$DIFF" ]; then
    echo -e "\033[1;32m✅ No diffs found.\033[0m"
    exit 0
fi

# Check if clang-tidy-diff.py script is available
if [ ! -f clang-tidy-diff.py ]; then
    echo -e "\033[1;31m❌ clang-tidy-diff.py not found.\033[0m"
    exit 1
fi

# Run clang-tidy-diff.py on the diff and show output
echo -e "\033[1;35m🧼 Running clang-tidy-diff.py on modified lines...\033[0m"
OUTPUT=$(echo "$DIFF" | python3 clang-tidy-diff.py -p1)

if [ $? -ne 0 ]; then
    echo -e "\033[1;31m❌ clang-tidy-diff.py encountered an error:\033[0m"
    echo "$OUTPUT"
    exit 1
fi

# Display the clang-tidy-diff.py output
echo -e "\033[1;32m✅ No issues detected by clang-tidy-diff.py!\033[0m"
echo "$OUTPUT"
