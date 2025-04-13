#!/bin/bash

# Usage: ./check_pr_format.sh <pr_number> [base_branch]
# Example: ./check_pr_format.sh 123 main

pr_number=$1
base_branch=${2:-main}

# Check if PR number is provided
if [ -z "$pr_number" ]; then
    echo -e "\033[1;31m❌ Usage: $0 <pr_number> [base_branch]\033[0m"
    exit 1
fi

# PR branch and remote name
pr_branch="pr-$pr_number"
remote_name="temp-pr-remote"

# Fetch the PR branch from origin (default remote)
echo -e "\033[1;34m📥 Fetching PR #$pr_number from origin...\033[0m"
git fetch origin pull/$pr_number/head:$pr_branch || { echo -e "\033[1;31m❌ Failed to fetch PR from origin\033[0m"; exit 1; }

# Get list of modified files with relevant extensions (C, C++, Java, JS, etc.)
extensions="c|cpp|cc|cxx|java|js|json|m|h|proto|cs"
echo -e "\033[1;36m🔍 Finding modified files between $base_branch and $pr_branch...\033[0m"
modified_files=$(git diff --name-only $base_branch $pr_branch | grep -E "\.(${extensions})$")

# If no relevant files are modified, exit
if [ -z "$modified_files" ]; then
    echo -e "\033[1;32m✅ No relevant files modified in this PR.\033[0m"
    exit 0
fi

# Show the modified files
echo -e "\033[1;33m📂 Modified files:\033[0m"
echo "$modified_files"

# Checkout to the PR branch
git checkout $pr_branch >/dev/null

# Check formatting issues with clang-format
echo -e "\033[1;35m🧼 Checking formatting issues with clang-format...\033[0m"
clang_output=$(git clang-format $base_branch --diff -- $modified_files)

# If there are formatting issues, print them
if [ -n "$clang_output" ] && ! echo "$clang_output" | grep -q "no modified files to format"; then
    echo -e "\033[1;31m🚨 Format issues detected:\033[0m"
    echo -e "\033[1;37m--------------------------------------\033[0m"
    
    # Show original unformatted code
    echo -e "\033[1;31mOriginal Code (Unformatted):\033[0m"
    echo "$clang_output" | grep -E "^\- " | cut -d ' ' -f 2-

    echo -e "\033[1;32m--------------------------------------\033[0m"
    
    # Show formatted code
    echo -e "\033[1;32mFormatted Code (After git clang-format):\033[0m"
    echo "$clang_output" | grep -E "^\+ " | cut -d ' ' -f 2-

    echo -e "\033[1;37m--------------------------------------\033[0m"
    echo -e "\033[1;33m💡 Suggested Fix:\033[0m"
    echo -e "   \033[1;32mgit clang-format $base_branch\033[0m"
    echo -e "\033[1;34m📘 This will auto-fix the formatting for the changed lines.\033[0m"
    exit 1
else
    echo -e "\033[1;32m✅ No formatting issues detected!\033[0m"
    exit 0
fi
