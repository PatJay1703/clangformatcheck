import subprocess
import difflib

# Get the list of modified files
def get_modified_files():
    result = subprocess.run(['git', 'diff', '--name-only', 'HEAD^', 'HEAD'], stdout=subprocess.PIPE)
    modified_files = result.stdout.decode('utf-8').splitlines()
    
    return modified_files

# Get the diff for the modified lines
def get_diff(file):
    result = subprocess.run(['git', 'diff', 'HEAD^', 'HEAD', '--', file], stdout=subprocess.PIPE)
    return result.stdout.decode('utf-8')

# Run clang-format on the changed lines
def apply_clang_format(line):
    result = subprocess.run(['clang-format'], input=line.encode('utf-8'), stdout=subprocess.PIPE)
    return result.stdout.decode('utf-8')

# Show the diff between original and formatted code
def show_diff(original, formatted):
    diff = difflib.unified_diff(original.splitlines(), formatted.splitlines(), lineterm='', fromfile='original', tofile='formatted')
    return '\n'.join(diff)

# Main function to process files and show diffs
def process_files():
    modified_files = get_modified_files()
    for file in modified_files:
        # Get the diff for the modified lines in the file
        file_diff = get_diff(file)
        
        # Split the diff into lines and find the added lines
        original_lines = []
        formatted_lines = []
        
        for line in file_diff.splitlines():
            if line.startswith('+'):  # Added line
                original_lines.append(line[1:])  # Remove the "+" sign
                formatted_line = apply_clang_format(line[1:])  # Apply clang-format on the line
                formatted_lines.append(formatted_line)
            elif not line.startswith('-'):
                # Keep unchanged lines
                original_lines.append(line)
                formatted_lines.append(line)

        # Show the difference between the original and formatted code
        diff_output = show_diff('\n'.join(original_lines), '\n'.join(formatted_lines))
        print(f"Diff for {file}:\n{diff_output}")

# Run the process
if __name__ == "__main__":
    process_files()
