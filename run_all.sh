#!/bin/bash
CONFIG="scripts_config.yaml"

run_if_enabled() {
	  local key=$1
	    local script=$2
	      if yq e ".$key" "$CONFIG" | grep -q true; then
		          echo "Running $script"
			      bash "$script"
			        else
					    echo "Skipping $script"
					      fi
run_if_enabled check_format.sh check_format.sh
run_if_enabled check_pr_format.sh check_pr_format.sh
run_if_enabled clang_tidy_check.sh clang_tidy_check.sh
run_if_enabled clang_tidy_checker.sh clang_tidy_checker.sh
run_if_enabled class_check.sh class_check.sh
run_if_enabled git_clang_format_modified.sh git-clang-format-modified.sh
run_if_enabled llvmheader.sh llvmheader.sh
run_if_enabled naming_conventions_check.sh naming_conventions_check.sh
run_if_enabled run_clang_tidy_for_prs.sh run_clang_tidy_for_prs.sh

