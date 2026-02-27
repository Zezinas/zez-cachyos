#!/bin/bash

set -e

echo "Installing greetd and tuigreet..."
sudo pacman -S --noconfirm greetd greetd-tuigreet

CONFIG_FILE="/etc/greetd/config.toml"

echo "Creating greetd config..."

sudo mkdir -p /etc/greetd

sudo tee "$CONFIG_FILE" > /dev/null <<EOF
[terminal]
vt = 1

[default_session]
command = "tuigreet --cmd uwsm start hyprland.desktop"

[initial_session]
command = "uwsm start hyprland.desktop"
user = "$USER"
EOF

echo "Enabling greetd service..."
sudo systemctl enable --now greetd.service

echo "Done! greetd is installed and configured."
