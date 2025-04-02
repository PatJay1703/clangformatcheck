#!/bin/sh

# Check if we are on a valid commit
if git rev-parse --verify HEAD >/dev/null 2>&1
then
    against=HEAD
else
    # Initial commit: diff against an empty tree object
    against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
fi

# Run clang-format on staged changes and capture the output
clangformatout=$(git clang-format --diff --staged -q)

# If there are formatting issues, show the differences
if [ "$clangformatout" != "" ]
then
    echo "Format errors detected in the following files:"
    echo "$clangformatout"
    echo "--------------------------------------------------------"
    echo "To fix the formatting, use: git clang-format"
    exit 1
fi

echo "No formatting issues detected!"
