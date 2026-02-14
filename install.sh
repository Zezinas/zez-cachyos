#!/usr/bin/env bash
set -euo pipefail

REPO_OWNER="Zezinas"
REPO_NAME="zez-cachyos"
BRANCH="main"
CONFIG_PATH=".config"
SCRIPTS_DIR="$HOME/.config/zez-scripts"

echo "🚀 Starting CachyOS bootstrap install"

# 1️⃣ Copy .config from GitHub
echo "📡 Downloading .config from GitHub..."
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

# Downloading zip archive of repo
ZIP_URL="https://github.com/${REPO_OWNER}/${REPO_NAME}/archive/refs/heads/${BRANCH}.zip"
curl -fsSL "$ZIP_URL" -o "$TMP_DIR/repo.zip"

echo "📂 Extracting .config..."
unzip -q "$TMP_DIR/repo.zip" -d "$TMP_DIR"
REPO_EXTRACTED="$TMP_DIR/${REPO_NAME}-${BRANCH}"

if [[ -d "$REPO_EXTRACTED/$CONFIG_PATH" ]]; then
    echo "📂 Merging .config into existing ~/.config"
    mkdir -p "$HOME/.config"
    cp -r "$REPO_EXTRACTED/$CONFIG_PATH/"* "$HOME/.config/"
else
    echo "❌ .config folder not found in repo"
    exit 1
fi

echo "✅ .config copied successfully"

# 2️⃣ Run scripts inside ~/.config/zez-scripts
echo "📜 Running user-defined scripts..."

# List scripts explicitly, so you can include/exclude
SCRIPTS_TO_RUN=(
    "install_packages.sh"
    "setup_ssh.sh"
)

for script in "${SCRIPTS_TO_RUN[@]}"; do
    SCRIPT_PATH="$SCRIPTS_DIR/$script"

    if [[ ! -f "$SCRIPT_PATH" ]]; then
        echo "⚠️  Script not found: $script, skipping..."
        continue
    fi

    echo "▶▶ Running $script"
    if ! bash "$SCRIPT_PATH"; then
        echo
        echo "❌ Script failed: $script"
        echo "🛑 Installation stopped."
        exit 1
    fi
    echo "✅ Completed $script"
    echo
done

echo "🎉 All scripts completed successfully!"
