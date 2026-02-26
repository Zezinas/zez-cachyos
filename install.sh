#!/bin/bash
# install.sh - Run multiple Zez-CachyOS scripts directly from GitHub

# --- CONFIGURATION ---
BASE_URL="https://raw.githubusercontent.com/Zezinas/zez-cachyos/main/zez-scripts/"
SCRIPTS=(
    "install_packages.sh"
    "setup_ssh.sh"
    "install_uwsm.sh"
)

echo "=== Zez-CachyOS Installer (Direct) ==="

# Run each script
for script in "${SCRIPTS[@]}"; do
    URL="${BASE_URL}${script}"
    echo "Running $script..."
    curl -fsSL "$URL" | bash
    if [ $? -ne 0 ]; then
        echo "⚠️ Script $script failed!"
    fi
done

echo "=== Installation finished ==="
