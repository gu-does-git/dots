#!/bin/bash

SOURCE_DIR="./automounts"
TARGET_DIR="/etc/systemd/system"

# --- Copy files not present in target folder ---

echo "Starting file synchronization from $SOURCE_DIR to $TARGET_DIR..."

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist."
    exit 1
fi

# Check if target directory exists, if not, create it
if [ ! -d "$TARGET_DIR" ]; then
    echo "Target directory '$TARGET_DIR' does not exist. Creating it..."
    mkdir -p "$TARGET_DIR"
    if [ $? -ne 0 ]; then
        echo "Error: Could not create target directory '$TARGET_DIR'."
        exit 1
    fi
fi

# Use rsync with --ignore-existing to copy only new files
# -a: archive mode (preserves permissions, timestamps, etc.)
# -v: verbose output
# --ignore-existing: skip updating files that already exist
sudo rsync -av --ignore-existing "$SOURCE_DIR/" "$TARGET_DIR/"

if [ $? -eq 0 ]; then
    echo "File synchronization completed successfully."
else
    echo "Error during file synchronization. Please check the output above for details."
fi

echo "" # Add a blank line for better readability

# --- Get a space-separated list of all files in the source folder ---

echo "Generating a space-separated list of files in $SOURCE_DIR..."

# Find all files in the target directory and print them separated by space
# -type f: only consider files (not directories)
# -printf "%f ": print only the filename (%f) followed by a space
FILE_LIST=$(find "$SOURCE_DIR" -maxdepth 1 -type f -printf "%f ")

echo "Files in $SOURCE_DIR:"
echo "$FILE_LIST"

echo "" # Add a blank line

# --- Run the systemctl enable command ---

sudo systemctl enable $FILE_LIST

echo "" # Add a blank line

# --- Add symbolic links ---

echo "Adding symbolic links..."

# Remove all target dirs
SYMBOLIC_TARGETS=(
"$HOME/Documents"
"$HOME/Downloads"
"$HOME/Music"
"$HOME/Pictures"
"$HOME/Videos"
)
for TARGET in "${SYMBOLIC_TARGETS[@]}"; do
    if [ -d "$TARGET" ]; then
        sudo rm -rf $TARGET # Use -rf for forceful recursive removal, typical for cleanup
    else 
        echo "Target $TARGET not found."
    fi
done

# Add all links
LINKS=(
"/srv/hdds/Documents $HOME"
"/srv/hdds/Downloads $HOME"
"/srv/hdds/Music $HOME"
"/srv/hdds/Pictures $HOME"
"/srv/hdds/Videos $HOME"
)
for LINK in "${LINKS[@]}"; do
    sudo ln -s $LINK
done

echo "Automount finished."
