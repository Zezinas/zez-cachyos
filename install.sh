#!/bin/bash
# install.sh - Run multiple Zez-CachyOS scripts directly from GitHub
# ran using: bash <(curl -sL https://raw.githubusercontent.com/Zezinas/zez-cachyos/main/install.sh)

# --- CONFIGURATION ---
BASE_URL="https://raw.githubusercontent.com/Zezinas/zez-cachyos/main/zez-scripts/"
SCRIPTS=(
    "install_packages.sh"
    "setup_ssh.sh"
    "setup_brightness.sh"
    "setup_config.sh"
    "install_greetd.sh"
)

echo "=== Zez-CachyOS Installer (Direct) ==="

# Run each script
for script in "${SCRIPTS[@]}"; do
    URL="${BASE_URL}${script}"
    echo "Running $script..."
    # Use bash <(curl ...) to allow interactive prompts (passwords/inputs)
    if bash <(curl -fsSL "$URL"); then
        echo "✅ $script finished successfully"
    else
        echo "⚠️ Script $script failed!"
        # Optional: exit 1 if you want to stop the whole process on failure
    fi
done

echo "=== Installation finished ==="
