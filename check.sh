#!/usr/bin/env bash

set -euo pipefail

echo "📦 Checking installed packages..."

# List of packages to check
PACKAGES=(
    # Core Hyprland + Wayland
    hyprland
    waybar
    wl-clipboard
    xorg-xwayland
    xdg-desktop-portal-hyprland
    hyprpaper
    hypridle
    hyprlock
    hyprcursor
    cliphist

    # Utilities
    fastfetch
    nano
    openssh
    samba

    # Apps
    alacritty
    nemo
    zed
    discord

    # AUR apps
    zen-browser
)

for pkg in "${PACKAGES[@]}"; do
    if pacman -Q "$pkg" &>/dev/null || yay -Q "$pkg" &>/dev/null; then
        echo "✅ $pkg is installed"
    else
        echo "❌ $pkg is NOT installed"
    fi
done

echo "🎉 Package check complete!"
