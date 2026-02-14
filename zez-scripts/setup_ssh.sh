#!/usr/bin/env bash

set -e
trap 'echo "❌ Error occurred on line $LINENO"; exit 1' ERR

echo "🔐 Setting up SSH..."

# Enable and start SSH
sudo systemctl enable --now sshd

# Show SSH status (non-blocking)
systemctl is-active --quiet sshd && echo "✅ sshd is running"

# Firewall setup (ufw)
if command -v ufw &>/dev/null; then
    echo "🔥 Configuring UFW for SSH..."
    sudo ufw allow ssh
    sudo ufw --force enable
    sudo ufw status verbose
else
    echo "⚠️ ufw not installed, skipping firewall configuration"
fi

# Show IP addresses
echo "🌐 Available IPv4 addresses:"
ip -4 addr show | awk '/inet / && $2 !~ /^127/ { print $2 }' | cut -d/ -f1
