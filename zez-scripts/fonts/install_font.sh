#!/bin/bash

# Source folder relative to the script
FONT_SRC="./SF-Pro"

# Target local fonts folder
FONT_DEST="$HOME/.local/share/fonts/SF-Pro"

# Create the local fonts directory if it doesn't exist
mkdir -p "$FONT_DEST"

# Copy all .otf and .ttf fonts from the source to the destination
cp "$FONT_SRC"/*.{otf,ttf} "$FONT_DEST" 2>/dev/null

# Update font cache
fc-cache -fv

# Verify installation
echo "Installed SF Pro fonts:"
fc-list | grep "SF Pro"

echo "✅ SF Pro fonts installed successfully!"
