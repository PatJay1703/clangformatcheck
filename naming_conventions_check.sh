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
git checkout pr-$PR_NUMBER

# Install clang if not installed
if ! command -v clang &> /dev/null; then
  echo "clang could not be found, installing it..."
  sudo apt-get update
  sudo apt-get install -y clang
fi

# Get the list of modified .cpp and .h files in the PR
pr_files=$(git diff --name-only origin/main...HEAD -- '*.cpp' '*.h')

if [ -z "$pr_files" ]; then
  echo "No relevant .cpp or .h files to check in PR #$PR_NUMBER."
  exit 0
fi

# Loop over modified files
for file in $pr_files; do
  if [[ $file == *.cpp || $file == *.h ]]; then
    echo "────────────────────────────────────────────"
    echo "Checking file: $file"
    echo "────────────────────────────────────────────"

    # Get the modified lines between the last commit and the current one for this file
    modified_lines=$(git diff HEAD^ HEAD -- "$file" | grep '^[+]' | sed 's/^+//')

    # Process the modified lines only
    while IFS= read -r line; do
      line_num=$(grep -n -m 1 "$line" "$file" | cut -d: -f1)

      # Check class names
      if [[ "$line" =~ class[[:space:]]+[a-z] ]]; then
        echo "❌ [Line $line_num] Class name should start with an uppercase letter."
        echo "   ↪ Code: $line"
        echo "   💡 Fix: Rename class to start with a capital letter (e.g. TextFileReader)"
        echo
      fi

      # Check variable names
      if [[ "$line" =~ [A-Z][a-zA-Z0-9_]* ]]; then
        echo "❌ [Line $line_num] Variable names should start with a lowercase letter and be in camelCase."
        echo "   ↪ Code: $line"
        echo "   💡 Fix: Rename variable to camelCase (e.g. leader, boatCount)"
        echo
      fi

      # Check function names
      if [[ "$line" =~ void[[:space:]]+[A-Z] ]]; then
        echo "❌ [Line $line_num] Function names should start with a lowercase letter and be verb-like."
        echo "   ↪ Code: $line"
        echo "   💡 Fix: Rename function to camelCase verb (e.g. openFile(), calculateSum())"
        echo
      fi

      # Check enum declarations
      if [[ "$line" =~ enum[[:space:]]+[a-z] ]]; then
        echo "❌ [Line $line_num] Enum names should start with an uppercase letter."
        echo "   ↪ Code: $line"
        echo "   💡 Fix: Rename enum to start with a capital (e.g. ValueKind)"
        echo
      fi

      # Check enum values for Kind suffix
      if [[ "$line" =~ enum && ! "$line" =~ Kind$ ]]; then
        echo "❌ [Line $line_num] Enum used as a discriminator should have a 'Kind' suffix."
        echo "   ↪ Code: $line"
        echo "   💡 Fix: Use 'ValueKind', 'TokenKind', etc."
        echo
      fi

    done <<< "$modified_lines"
  fi
done

echo "✅ Naming convention checks complete."
