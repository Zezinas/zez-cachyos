#!/usr/bin/env bash

set -e

echo "==== Installing greetd + cage + nwg-hello on CachyOS (Hyprland) ===="

# ---- Must be root ----
if [[ $EUID -ne 0 ]]; then
  echo "Please run as root"
  exit 1
fi

# ---- Install packages ----
echo "Installing required packages..."
pacman -S --needed --noconfirm \
  greetd \
  cage \
  nwg-hello

# ---- Create greetd config ----
echo "Configuring greetd..."

mkdir -p /etc/greetd

cat > /etc/greetd/config.toml <<EOF
[terminal]
vt = 1

[default_session]
command = "cage -s -- nwg-hello"
user = "greeter"
EOF

# ---- Create greeter user if missing ----
if ! id greeter &>/dev/null; then
  echo "Creating greeter user..."
  useradd -m -G video,audio,input greeter
fi

# ---- Create nwg-hello config ----
echo "Configuring nwg-hello..."

mkdir -p /etc/nwg-hello

cat > /etc/nwg-hello/config <<EOF
[greeter]
layer-shell = true

[background]
path = "/usr/share/backgrounds/cachyos-wallpaper.jpg"
fit = "cover"

[appearance]
gtk-theme = "Adwaita-dark"
icon-theme = "Papirus-Dark"
font = "Sans 11"

[commands]
reboot = "systemctl reboot"
poweroff = "systemctl poweroff"
EOF

# ---- Ensure Hyprland session file exists ----
echo "Ensuring Hyprland session entry..."

mkdir -p /usr/share/wayland-sessions

cat > /usr/share/wayland-sessions/hyprland.desktop <<EOF
[Desktop Entry]
Name=Hyprland
Comment=Hyprland Wayland Compositor
Exec=Hyprland
Type=Application
EOF

# ---- Enable greetd ----
echo "Enabling greetd service..."
systemctl enable greetd.service

echo
echo "==== Installation Complete ===="
echo "Reboot your system to test greetd."
echo
