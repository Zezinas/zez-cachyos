#!/bin/bash

# Define variables
REPO_URL="https://github.com/Zezinas/zez-cachyos.git"
TEMP_DIR="$(mktemp -d)"

# Clone the repository (only the .config folder is needed)
git clone --depth 1 "$REPO_URL" "$TEMP_DIR"

# Copy the .config folder contents to ~/.config
mkdir -p "$HOME/.config"
cp -a "$TEMP_DIR/.config/." "$HOME/.config/"

# Clean up
rm -rf "$TEMP_DIR"

echo "Cachyos .config has been copied to ~/.config"




read -rp " --- --- Install extras? --- --- (y/n): " INSTALL_EXTRAS

if [[ "$INSTALL_EXTRAS" =~ ^[Yy]$ ]]; then
    echo "Installing extras..."
    bash <(curl -fsSL https://raw.githubusercontent.com/Zezinas/zez-cachyos/main/zez-scripts/install_extras.sh)
else
    echo "Skipping extras."
fi


# tar -czf extras.tar.gz extras/
# gpg -c extras.tar.gz
#
# extras.tar.gz.gpg
