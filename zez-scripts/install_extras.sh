#!/bin/bash
set -e

# Install missing dependencies (Arch / CachyOS)
DEPS=()

command -v curl >/dev/null 2>&1 || DEPS+=("curl")
command -v gpg  >/dev/null 2>&1 || DEPS+=("gnupg")
command -v tar  >/dev/null 2>&1 || DEPS+=("tar")

if [ ${#DEPS[@]} -ne 0 ]; then
    echo "Installing missing dependencies: ${DEPS[*]}"
    sudo pacman -S --needed --noconfirm "${DEPS[@]}"
fi

EXTRAS_URL="https://github.com/Zezinas/zez-cachyos/releases/latest/download/extras.tar.gz.gpg"
TEMP_DIR="$(mktemp -d)"

trap 'rm -rf "$TEMP_DIR"' EXIT

echo "Downloading extras..."
curl -fL "$EXTRAS_URL" -o "$TEMP_DIR/extras.tar.gz.gpg"

echo "Decrypting..."
gpg --output "$TEMP_DIR/extras.tar.gz" \
    --decrypt "$TEMP_DIR/extras.tar.gz.gpg" || {
    echo "❌ Decryption failed"
    exit 1
}

echo "Extracting..."
tar -xzf "$TEMP_DIR/extras.tar.gz" -C "$TEMP_DIR"

# Install fonts
if [[ -f "$TEMP_DIR/extras/fonts/install_font.sh" ]]; then
    chmod +x "$TEMP_DIR/extras/fonts/install_font.sh"
    "$TEMP_DIR/extras/fonts/install_font.sh"
fi

# Copy assets
if [[ -d "$TEMP_DIR/extras/assets" ]]; then
    mkdir -p "$HOME/.config/quickshell"
    cp -a "$TEMP_DIR/extras/assets/" "$HOME/.config/quickshell/"
fi

echo "✅ Extras installed"


# tar -czf extras.tar.gz extras/
# gpg -c extras.tar.gz
# Password
# extras.tar.gz.gpg
