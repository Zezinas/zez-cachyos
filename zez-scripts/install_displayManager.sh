#!/usr/bin/env bash

set -e

echo "==> Installing greetd + wlgreet + cage..."
sudo pacman -S --noconfirm greetd greetd-wlgreet cage

CONFIG_FILE="/etc/greetd/config.toml"

echo "==> Writing minimal greetd configuration..."
sudo tee "$CONFIG_FILE" > /dev/null << 'EOF'
[default_session]
command = "cage -s -- wlgreet --cmd 'uwsm start hyprland.desktop'"
user = "greeter"
EOF

echo "==> Enabling greetd..."
sudo systemctl enable greetd

echo
echo "✅ Setup complete!"
echo
echo "To test greetd manually, run:"
echo "  sudo systemctl start greetd"
echo
echo "If it works, you can reboot to use it automatically."
