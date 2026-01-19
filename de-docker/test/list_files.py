from pathlib import Path

current_dir = Path.cwd()          # Get current working directory
current_file = Path(__file__).name   # Get THIS script's filename

print(f"Files in {current_dir}:")

for filepath in current_dir.iterdir():    # Loop through all items in directory
    if filepath.name == current_file:     # Skip this script itself
        continue

    print(f"  - {filepath.name}")         # Print filename
    
    if filepath.is_file():                # If it's a file (not directory)
        content = filepath.read_text(encoding='utf-8')  # Read entire file
        print(f"    Content: {content}")  # Print its content