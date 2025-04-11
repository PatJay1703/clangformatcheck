#!/bin/bash

# Usage: ./check_pr_format.sh <pr_number> [base_branch]
# Example: ./check_pr_format.sh 128526 main

pr_number=$1
base_branch=${2:-main}
remote_name="temp-pr-remote"

if [ -z "$pr_number" ]; then
    echo -e "\033[1;31m❌ Usage: $0 <pr_number> [base_branch]\033[0m"
    exit 1
fi

# Step 1: Get PR metadata via GitHub API
echo -e "\033[1;34m🌐 Fetching PR metadata from GitHub...\033[0m"
auth_header=""
[ -n "$GITHUB_TOKEN" ] && auth_header="Authorization: token $GITHUB_TOKEN"

response=$(curl -s -H "$auth_header" https://api.github.com/repos/llvm/llvm-project/pulls/$pr_number)

source_repo=$(echo "$response" | jq -r .head.repo.clone_url)
source_branch=$(echo "$response" | jq -r .head.ref)

if [[ "$source_repo" == "null" || "$source_branch" == "null" ]]; then
    echo -e "\033[1;31m❌ Invalid PR number or failed to fetch PR metadata.\033[0m"
    exit 1
fi

pr_branch="pr-$pr_number"

# Step 2: Add remote and shallow fetch
echo -e "\033[1;34m🔗 Adding remote from $source_repo...\033[0m"
git remote add $remote_name "$source_repo" 2>/dev/null || true

echo -e "\033[1;34m📥 Fetching PR #$pr_number from $source_repo (shallow)...\033[0m"
git fetch --depth=1 $remote_name $source_branch:$pr_branch || {
    echo -e "\033[1;31m❌ Failed to fetch PR branch.\033[0m"
    git remote remove $remote_name
    exit 1
}

# Step 3: Filter modified files
extensions="c|cpp|cc|cxx|java|js|json|m|h|proto|cs"
echo -e "\033[1;36m🔍 Finding modified files between $base_branch and $pr_branch...\033[0m"

modified_files=$(git diff --name-only $base_branch $pr_branch | \
    grep -Ev ".*(pb|generated).*" | \
    grep -E "\.(${extensions})$")

if [ -z "$modified_files" ]; then
    echo -e "\033[1;32m✅ No relevant files modified in this PR.\033[0m"
    git remote remove $remote_name
    exit 0
fi

echo -e "\033[1;33m📂 Modified files:\033[0m"
echo "$modified_files"

# Step 4: Check formatting
git checkout $pr_branch >/dev/null

echo -e "\033[1;35m🧼 Checking formatting issues with clang-format...\033[0m"
clang_output=$(git clang-format $base_branch --diff -- $modified_files)

if [ -n "$clang_output" ] && ! echo "$clang_output" | grep -q "no modified files to format"; then
    echo -e "\033[1;31m🚨 Format issues detected:\033[0m"
    echo -e "\033[1;37m--------------------------------------\033[0m"
    echo -e "\033[1;31mOriginal Code (Unformatted):\033[0m"
    echo "$clang_output" | grep -E "^\- " | cut -d ' ' -f 2-
    echo -e "\033[1;32m--------------------------------------\033[0m"
    echo -e "\033[1;32mFormatted Code (After git clang-format):\033[0m"
    echo "$clang_output" | grep -E "^\+ " | cut -d ' ' -f 2-
    echo -e "\033[1;37m--------------------------------------\033[0m"
    echo -e "\033[1;33m💡 Suggested Fix:\033[0m"
    echo -e "   \033[1;32mgit clang-format $base_branch\033[0m"
    echo -e "\033[1;34m📘 This will auto-fix the formatting for the changed lines.\033[0m"
    git remote remove $remote_name
    exit 1
else
    echo -e "\033[1;32m✅ No formatting issues detected!\033[0m"
    git remote remove $remote_name
    exit 0
fi
