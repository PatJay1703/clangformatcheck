#!/bin/bash
CONFIG="scripts_config.yaml"
PR_NUMBER="$1"

run_if_enabled() {
  local key=$1
  local script=$2
  local needs_pr=$3

  if yq e ".$key" "$CONFIG" | grep -q true; then
    echo "✅ Running $script"
    if [ "$needs_pr" = true ]; then
      bash "$script" "$PR_NUMBER"
    else
      bash "$script"
    fi
  else
    echo "❌ Skipping $script"
  fi
}


run_if_enabled check_pr_format check_pr_format.sh true

run_if_enabled class_check class_check.sh false

run_if_enabled llvmheader llvmheader.sh false
run_if_enabled naming_conventions_check naming_conventions_check.sh false


