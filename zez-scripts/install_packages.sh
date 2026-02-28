#!/usr/bin/env bash
set -e
trap 'echo "Error occurred on line $LINENO"; exit 1' ERR

echo "=== Starting package installation ==="

# --- CORE HELPERS ---
echo "Installing yay (AUR helper)..."
sudo pacman -Syu --noconfirm yay

# --- OFFICIAL REPO PACKAGES ---
# Core Hyprland + Wayland essentials
OFFICIAL_CORE=(
    hyprland                   # Wayland compositor
    wl-clipboard               # Clipboard integration for Wayland
    xorg-xwayland              # XWayland support for running X apps
    xdg-desktop-portal-hyprland # Flatpak & screen sharing integration
    fastfetch                  # System info summary
    nano                       # Terminal text editor
    openssh                    # SSH client/server
    samba                      # SMB/CIFS file sharing

    uwsm                       # Universal Wayland Sesion Manager
    libnewt                    # Terminal text editor (uwsm dependency)

        # --- Login & Session Management ---
        # uwsm                       # Session manager
        # libnewt                    # UI dependency for uwsm
        # greetd                     # Display manager daemon
        # qtgreet                    # The Qt-based GUI
        # cage                       # Kiosk compositor to run qtgreet
)

# Core utilities / applications
OFFICIAL_UTILS=(
    alacritty                  # GPU-accelerated terminal emulator
    nemo                       # Graphical file manager
    zed                        # Modern code editor
    discord                    # Chat / communication app
)

# Optional extras
OPTIONAL_OFFICIAL=(
    cliphist                   # Clipboard history manager
    hyprpaper                  # Wallpaper manager for Hyprland
    hypridle                   # Idle manager (suspend, lock, etc.)
    hyprlock                   # Lock screen utility
    hyprcursor                 # Cursor theme/management
)

# Install official repo packages
echo "Installing core packages from official repos..."
sudo pacman -S --noconfirm --needed "${OFFICIAL_CORE[@]}"

echo "Installing optional packages from official repos..."
sudo pacman -S --noconfirm --needed "${OPTIONAL_OFFICIAL[@]}"

echo "Installing core utilities from official repos..."
sudo pacman -S --noconfirm --needed "${OFFICIAL_UTILS[@]}"

# --- AUR PACKAGES ---
# Optional / AUR apps
AUR_PACKAGES=(
    vicinae-bin                # Raycast-like launcher
    zen-browser                # Lightweight Chromium-based browser
    quickshell                 # Custom shell for Hyprland
)

echo "Installing AUR packages via yay..."
yay -S --noconfirm --needed "${AUR_PACKAGES[@]}"

echo "=== Package installation completed! ==="


# -------------------------------
# Packages still under research / undecided
#
# walker / wofi              # Application launcher for Wayland (not decided)
# mako                       # Notifications daemon for Wayland (not decided)
# polkit-gnome / polkit-kde-agent / lxqt-policykit # GUI authentication dialogs (not decided)
# greetd + tuigreet          # Lightweight display manager (not decided)
