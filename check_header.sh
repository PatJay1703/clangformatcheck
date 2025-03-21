#!/bin/bash

# Define the expected header pattern
EXPECTED_HEADER="^//===----------------------------------------------------------------------===//"
EXPECTED_LICENSE="^// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions."
EXPECTED_SPDX="^// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception"
EXPECTED_DOXYGEN="^/// \file"

# Function to check the header for each file
check_header() {
  local file=$1
  echo "Checking file: $file"
  
  # Check if the file starts with the expected header
  if ! head -n 20 "$file" | grep -q -E "$EXPECTED_HEADER"; then
    echo "Error: Missing or incorrect header in $file. The header must start with the required pattern."
    exit 1
  fi
  
  if ! head -n 20 "$file" | grep -q -E "$EXPECTED_LICENSE"; then
    echo "Error: Missing or incorrect license section in $file."
    exit 1
  fi

  if ! head -n 20 "$file" | grep -q -E "$EXPECTED_SPDX"; then
    echo "Error: Missing or incorrect SPDX section in $file."
    exit 1
  fi

  if ! head -n 20 "$file" | grep -q -E "$EXPECTED_DOXYGEN"; then
    echo "Error: Missing or incorrect doxygen comment section in $file."
    exit 1
  fi

  echo "Header is correct in $file"
}

# Check each file passed to the script
for file in "$@"; do
  check_header "$file"
done
