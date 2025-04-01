import subprocess
import sys
import os

# Function to extract changed lines from git diff
def get_changed_lines():
    # Run git diff to get the diff between the current branch and the main branch
    diff_command = ["git", "diff", "origin/main..HEAD"]  # Correct diff command
    diff_output = subprocess.check_output(diff_command, encoding="utf-8")

    # Extract line numbers from the diff output
    changed_lines = set()
    for line in diff_output.splitlines():
        if line.startswith("@@"):
            # Line format: @@ -X,Y +A,B @@
            # Extract line numbers from the diff
            parts = line.split(" ")
            old_range = parts[1].strip("-").split(",")
            new_range = parts[2].strip("+").split(",")
            start_line = int(new_range[0])
            num_lines = int(new_range[1])
            for i in range(start_line, start_line + num_lines):
                changed_lines.add(i)
    return changed_lines

# Function to run clang-format on specific lines
def format_lines(changed_lines, file_path):
    # Check if a .clang-format file exists in the root directory
    clang_format_config = ".clang-format"
    
    # Run clang-format on the file, ensuring the correct configuration is used
    clang_format_cmd = ["clang-format", "-i", file_path]
    if os.path.exists(clang_format_config):
        clang_format_cmd.append("-style=file")  # Use the style from the .clang-format file
    
    subprocess.run(clang_format_cmd)  # Run clang-format on the file

    # After formatting, update the file with formatted content (no need for a temp file now)
    with open(file_path, 'r') as file:
        formatted_content = file.readlines()
    
    with open(file_path, 'w') as file:
        file.writelines(formatted_content)

def main():
    # Get the list of changed lines from the diff
    changed_lines = get_changed_lines()

    # If no changes found, exit
    if not changed_lines:
        print("No relevant changes to format.")
        return

    # Specify the files you want to format based on extensions
    extensions_to_check = [".c", ".cpp", ".cc", ".cxx", ".java", ".js", ".json", ".m", ".h", ".proto", ".cs"]

    # Get the changed files
    with open("changed_files.txt", "r") as file:
        changed_files = file.readlines()

    # Filter files based on the specified extensions
    files_to_format = [file.strip() for file in changed_files if any(file.endswith(ext) for ext in extensions_to_check)]

    # Run clang-format on only the changed lines in each file
    for file_path in files_to_format:
        if os.path.exists(file_path):
            format_lines(changed_lines, file_path)

if __name__ == "__main__":
    main()
