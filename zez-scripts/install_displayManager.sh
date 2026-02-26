#!/usr/bin/env bash

set -e

echo "==> Installing greetd, qtgreet, and cage..."
# qtgreet is in CachyOS / AUR. Cage is the kiosk compositor for the GUI.
sudo pacman -S --noconfirm greetd qtgreet cage

CONFIG_FILE="/etc/greetd/config.toml"

echo "==> Writing greetd configuration..."
sudo tee "$CONFIG_FILE" > /dev/null << 'EOF'
[terminal]
vt = 1

[default_session]
# 'user = greeter' runs the login screen.
# After you log in, qtgreet executes the uwsm command for your user.
command = "cage -s -- qtgreet --command 'uwsm start hyprland-uwsm.desktop'"
user = "greeter"
EOF

echo "==> Setting permissions for the greeter user..."
# Essential for Cage/QtGreet to access the GPU and mouse/keyboard
sudo usermod -aG video,input greeter

echo "==> Enabling greetd..."
sudo systemctl enable greetd

echo
echo "✅ Setup complete!"
echo "Then reboot to see your new GUI login screen."
