#!/bin/bash

# Define variables
REPO_URL="https://github.com/Zezinas/zez-cachyos.git"
TEMP_DIR="$(mktemp -d)"

# Clone the repository (only the .config folder is needed)
git clone --depth 1 "$REPO_URL" "$TEMP_DIR"

# Copy the .config folder contents to ~/.config
mkdir -p "$HOME/.config"
cp -a "$TEMP_DIR/.config/." "$HOME/.config/"

# Ask user
read -p "Install extra assets? (y/n): " INSTALL_EXTRAS

# ENCRYPTED EXTRAS - extras.tar.gz.gpg
if [[ "$INSTALL_EXTRAS" == "y" ]]; then
    echo "Decrypting extras..."

    if [[ ! -f "$TEMP_DIR/zez-scripts/extras.tar.gz.gpg" ]]; then
        echo "❌ Encrypted extras not found"
        rm -rf "$TEMP_DIR"
        exit 1
    fi

    if ! gpg --quiet --yes \
        --output "$TEMP_DIR/zez-scripts/extras.tar.gz" \
        --decrypt "$TEMP_DIR/zez-scripts/extras.tar.gz.gpg"; then

        echo "❌ Wrong password or decryption failed"
        rm -rf "$TEMP_DIR"
        exit 1
    fi

    echo "Extracting extras..."
    tar -xzf "$TEMP_DIR/zez-scripts/extras.tar.gz" -C "$TEMP_DIR"
    rm -f "$TEMP_DIR/zez-scripts/extras.tar.gz"

    # Install fonts
    if [[ -f "$TEMP_DIR/zez-scripts/extras/fonts/install_font.sh" ]]; then
        chmod +x "$TEMP_DIR/zez-scripts/extras/fonts/install_font.sh"
        "$TEMP_DIR/zez-scripts/extras/fonts/install_font.sh"
    fi

    # Copy assets
    if [[ -d "$TEMP_DIR/zez-scripts/extras/assets" ]]; then
        mkdir -p "$HOME/.config/quickshell"
        cp -a "$TEMP_DIR/zez-scripts/extras/assets/." "$HOME/.config/quickshell/"
    fi

    echo "✅ Extras installed"
fi

# Clean up
rm -rf "$TEMP_DIR"

echo "Cachyos .config has been copied to ~/.config"


# tar -czf extras.tar.gz extras/
# gpg -c extras.tar.gz
#
# extras.tar.gz.gpg
