#!/usr/bin/env bash

set -e
trap 'echo "Error occurred on line $LINENO"; exit 1' ERR

# installing yay pacman helper for AUR package management
sudo pacman -Syu --noconfirm yay

# Update system and install core Hyprland + Wayland essentials
sudo pacman -S --noconfirm --needed \
    hyprland \
    waybar \
    wl-clipboard \
    xorg-xwayland \
    xdg-desktop-portal-hyprland

# Optional extras
sudo pacman -S --noconfirm --needed \
    cliphist \
    hyprpaper \
    hypridle \
    hyprlock \
    hyprcursor

# Optional AUR packages
yay -S --noconfirm --needed \
    vicinae-bin

# Core utility from official repos
sudo pacman -S --noconfirm --needed \
    fastfetch \
    nano \
    openssh \
    samba

# Core apps from official repos
sudo pacman -S --noconfirm --needed \
    alacritty \
    nemo \
    zed \
    discord

# Optional / AUR apps (via yay)
yay -S --noconfirm --needed \
    zen-browser

# -------------------------------
# Package explanations (for reference)
#
# Core Hyprland + Wayland essentials
# hyprland        # Wayland compositor
# waybar          # Status bar
# walker            # Wayland launcher (wofi/walker)
# wl-clipboard    # Clipboard support
# xorg-xwayland   # XWayland support
# xdg-desktop-portal-hyprland  # Flatpak/screensharing
# ???            # Notifications (mako/swaync)
# ???           # GUI authentication (polkit-gnome/polkit-kde-agent/lxqt-policykit)
#
# Optional extras
# cliphist        # Clipboard history
# hyprpaper       # Wallpaper manager
# hypridle        # Idle manager
# hyprlock        # Lock screen
# hyprcursor      # Cursor manager
#
# vicinae-bin     # Raycast linux alternative
#
# ???
# greetd          # Lightweight display manager (greetd + tuigreet)
# greetd-tuigreet # Lightweight display manager (greetd + tuigreet)

# Optional / AUR apps (via yay)
#yay -S --needed \
#    ??? \
#    ???

# -------------------------------
# Package explanations (for reference)
#
# Core utility from official repos
# fastfetch      # Terminal emulator (GPU accelerated)
# nano           # Terminal text editor
# openssh        # SSH Secure shell server
# samba          # SMB/CIFS file sharing
#
# Optional / AUR apps
# ???
#

# -------------------------------
# Package explanations (for reference)
#
# Core apps from official repos
# alacritty      # Terminal emulator (GPU accelerated)
# nemo           # File manager (Finder-like features)
# zed            # Fast, modern code editor
# discord        # Chat / communication app
#
# Optional / AUR apps
# zen-browser    # Lightweight Chromium-based web browser
#
