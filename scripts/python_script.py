import subprocess
import sys
import os

# Function to extract changed lines from git diff
def get_changed_lines():
    # Run git diff to get the diff between the current branch and the main branch
    diff_command = ["git", "diff", "origin/main..HEAD"]  # Changed from ... to ..
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
    # Write a temporary file with only the changed lines
    temp_file_path = "temp_file.cpp"
    
    with open(file_path, 'r') as file:
        lines = file.readlines()
    
    # Create a temporary file with only the changed lines
    with open(temp_file_path, 'w') as temp_file:
        for i, line in enumerate(lines, 1):
            if i in changed_lines:
                temp_file.write(line)

    # Run clang-format on the temporary file
    subprocess.run(["clang-format", "-i", temp_file_path])

    # Replace the original file with the formatted lines from temp_file
    with open(file_path, 'w') as file:
        for i, line in enumerate(lines, 1):
            if i in changed_lines:
                # Replace the old line with the formatted line
                file.write(open(temp_file_path).readlines()[i-1])
            else:
                file.write(line)

    # Clean up temporary file
    os.remove(temp_file_path)

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
