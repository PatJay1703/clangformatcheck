#!/bin/bash

# Check if a PR number is provided
if [ -z "$1" ]; then
  echo "Please provide a pull request number as an argument."
  exit 1
fi

PR_NUMBER=$1

# Fetch the latest changes and check out the PR branch
echo "Fetching changes for PR #$PR_NUMBER"
git fetch origin pull/$PR_NUMBER/head:pr-$PR_NUMBER

# Checkout to the PR branch
git checkout pr-$PR_NUMBER

# Install clang-tidy if not installed
if ! command -v clang-tidy &> /dev/null; then
  echo "clang-tidy could not be found, installing it..."
  sudo apt-get update
  sudo apt-get install -y clang-tidy
fi

# Get the list of modified files in the PR
pr_files=$(git diff --name-only origin/main...HEAD -- '*.cpp' '*.h' '*.c' '*.cc' '*.cxx' \
                '*.proto' '*.cs' '*.m' '*.java' '*.js' '*.json')

if [ -z "$pr_files" ]; then
  echo "No relevant files to check in PR #$PR_NUMBER."
  exit 0
fi

# Run clang-tidy on modified files and suggest changes
for file in $pr_files; do
  echo "Running clang-tidy on file: $file"
  
  # Run clang-tidy with checks enabled and specify include directory if needed
  clang-tidy $file -checks=* -- -Iinclude
  
  # If clang-tidy fails, report the issues
  if [ $? -ne 0 ]; then
    echo "clang-tidy check failed for file: $file"
    echo "Displaying diff for the failed file: $file"
    git diff $file
    exit 1
  fi
done

echo "Clang-tidy checks completed for PR #$PR_NUMBER. No issues found."
