#!/usr/bin/env bash

set -e

echo "==> Installing uwsm..."
sudo pacman -S --noconfirm uwsm libnewt

echo "==> Detecting shell..."
SHELL_NAME=$(basename "$SHELL")

if [[ "$SHELL_NAME" == "bash" ]]; then
PROFILE="$HOME/.bash_profile"
elif [[ "$SHELL_NAME" == "zsh" ]]; then
PROFILE="$HOME/.zprofile"
else
echo "Unsupported shell: $SHELL_NAME"
echo "Please add the uwsm snippet manually."
exit 1
fi

echo "==> Using profile: $PROFILE"

# Ensure file exists

touch "$PROFILE"

# Backup

cp "$PROFILE" "$PROFILE.bak"

SNIPPET='

# >>> UWSM AUTO START >>>

if uwsm check may-start; then
exec uwsm start hyprland.desktop
fi

# <<< UWSM AUTO START <<<

'

echo "==> Checking if snippet already exists..."

if grep -q "UWSM AUTO START" "$PROFILE"; then
echo "Snippet already exists. Skipping."
else
echo "==> Adding uwsm startup snippet..."
echo "$SNIPPET" >> "$PROFILE"
fi

echo "==> Done!"
echo
echo "IMPORTANT:"
echo "- Log out and log back in (TTY)"
echo "- Or test manually with: uwsm start hyprland.desktop"
