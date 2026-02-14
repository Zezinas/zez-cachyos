#!/bin/bash

# Define variables
REPO_URL="https://github.com/Zezinas/zez-cachyos.git"
TEMP_DIR="$(mktemp -d)"

# Clone the repository (only the .config folder is needed)
git clone --depth 1 "$REPO_URL" "$TEMP_DIR"

# Copy the .config folder contents to ~/.config
rsync -avh --progress "$TEMP_DIR/.config/" "$HOME/.config/"

# Clean up
rm -rf "$TEMP_DIR"

echo "Cachyos .config has been copied to ~/.config"
