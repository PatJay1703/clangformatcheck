#!/bin/bash

# Check if the user provided a file to format
if [ $# -lt 1 ]; then
  echo "Usage: $0 <file>"
  exit 1
fi

FILE=$1

# Step 1: Get the diff of the modified lines in the file
MODIFIED_LINES=$(git diff --unified=0 -- $FILE | grep -E '^\+[^+]+' | sed 's/^+//')

if [ -z "$MODIFIED_LINES" ]; then
  echo "No modified lines found."
  exit 0
fi

# Step 2: Extract the modified lines and create a temporary file
TEMP_FILE=$(mktemp)
echo "$MODIFIED_LINES" > $TEMP_FILE

# Step 3: Run clang-format on the modified lines (this assumes clang-format is installed)
clang-format -i $TEMP_FILE

# Step 4: Replace the modified lines back in the original file
# First, get the original content of the modified lines
original_content=$(git show :$FILE | grep -E '^\+[^+]+' | sed 's/^+//')

# Step 5: Commit the staged changes
git add $FILE

echo "Formatted modified lines and staged the changes."
