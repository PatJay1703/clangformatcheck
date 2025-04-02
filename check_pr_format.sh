#!/bin/bash

# Usage: ./check_pr_format.sh <pr_number> [base_branch]
# Example: ./check_pr_format.sh 123 main

# Get input arguments
pr_number=$1
base_branch=${2:-main}

# Check if PR number is provided
if [ -z "$pr_number" ]; then
    echo "❌ Usage: $0 <pr_number> [base_branch]"
    exit 1
fi

# Create a local name for the PR branch
pr_branch="pr-$pr_number"

echo "📥 Fetching PR #$pr_number..."
git fetch origin pull/$pr_number/head:$pr_branch || { echo "❌ Failed to fetch PR"; exit 1; }

# Define extensions to check
extensions="c|cpp|cc|cxx|java|js|json|m|h|proto|cs"

echo "🔍 Finding files modified between $base_branch and $pr_branch..."
modified_files=$(git diff --name-only $base_branch $pr_branch | grep -E "\.(${extensions})$")

if [ -z "$modified_files" ]; then
    echo "✅ No relevant files modified in this PR."
    exit 0
fi

echo "📂 Modified files:"
echo "$modified_files"

# Checkout to the PR branch
git checkout $pr_branch >/dev/null

echo "🧼 Running clang-format on modified lines..."
clang_output=$(git clang-format $base_branch --diff -- $modified_files)

if [ -n "$clang_output" ] && ! echo "$clang_output" | grep -q "no modified files to format"; then
    echo " Format issues found:"
    echo "--------------------------------------"
    echo "$clang_output"
    echo "--------------------------------------"
    echo "💡 To fix formatting issues, run:"
    echo "    git clang-format $base_branch"
    exit 1
else
    echo "✅ No formatting issues detected!"
    exit 0
fi
