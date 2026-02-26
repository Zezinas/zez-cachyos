#!/usr/bin/env bash
set -e

echo "==> Installing greetd, cage, and nwg-hello..."
# nwg-hello is now in the official Arch Extra repos, but we'll use yay as a fallback.
sudo pacman -S --noconfirm --needed greetd cage nwg-hello

CONFIG_FILE="/etc/greetd/config.toml"

echo "==> Writing greetd configuration..."
sudo tee "$CONFIG_FILE" > /dev/null << EOF
[terminal]
vt = 1

[default_session]
# cage starts nwg-hello in kiosk mode (-s for VT switching support)
command = "cage -s -- nwg-hello"
user = "greeter"
EOF

echo "==> Configuring nwg-hello (Standalone)..."
sudo mkdir -p /etc/nwg-hello
# Copy default config if it doesn't exist, then overwrite with our custom uwsm session
[ ! -f /etc/nwg-hello/nwg-hello.json ] && sudo cp /etc/nwg-hello/nwg-hello-default.json /etc/nwg-hello/nwg-hello.json || true

sudo tee /etc/nwg-hello/nwg-hello.json > /dev/null << EOF
{
  "custom_sessions": [
    {
      "name": "Hyprland (UWSM)",
      "exec": "uwsm start hyprland-uwsm.desktop"
    }
  ],
  "monitor_nums": [],
  "form_on_monitors": [],
  "delay_secs": 1,
  "show_clock": true,
  "show_power_buttons": true,
  "gtk-theme": "Adwaita-dark",
  "gtk-icon-theme": "Adwaita",
  "gtk-cursor-theme": "Adwaita"
}
EOF

echo "==> Setting permissions for the greeter user..."
# Essential for GPU access and input handling in cage
sudo usermod -aG video,input greeter

echo "==> Enabling greetd..."
sudo systemctl enable greetd

echo
echo "✅ Setup complete!"
echo "Reboot to start your zero-persistence GUI login experience."
