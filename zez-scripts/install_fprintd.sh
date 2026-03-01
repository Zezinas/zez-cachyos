#!/bin/bash
#
# install_fprintd.sh
# Automate installation of fprintd + CS9711 driver on Arch-based distros

set -e

echo
echo "=== Fingerprint Setup Script for Arch/CachyOS ==="
echo

# 1. Check if CS9711 fingerprint device is connected
if ! lsusb | grep -q "2541:0236"; then
    echo "Fingerprint device (CS9711) not found."
    echo "Please connect the device and try again."
    exit 1
fi

# 2. Install runtime dependencies
echo
echo "--- Installing fprintd and opencv..."
sudo pacman -S --needed --noconfirm fprintd opencv

# 3. Install patched libfprint from AUR
echo
echo "--- Installing libfprint-cs9711-git (patched driver) from AUR..."
yay -S --noconfirm libfprint-cs9711-git

# 4. Restart fprintd service
echo
echo "--- Restarting fprintd service..."
sudo systemctl restart fprintd

echo
echo "Service status:"
systemctl status fprintd --no-pager

# 5. Enroll fingerprint for the current user
echo
echo "=== Fingerprint Enrollment ==="
echo "You will now be asked to scan your finger for enrollment."
echo
read -p "Press Enter to begin..."
fprintd-enroll -f left-index-finger

echo
echo "=== Enrollment complete! ==="
echo
echo "IMPORTANT: You still need to modify PAM configs so fingerprint can be used for sudo, login, etc."
echo "Open the relevant files (e.g.,sudo nano /etc/pam.d/sudo) and insert the line:"
echo
echo "auth sufficient pam_fprintd.so"
echo
echo "Be careful: incorrect PAM can prevent logins."
echo "If this is a fresh install, make a backup of the original files first."
echo
echo "DONE!"





# (optional??) Verify device
# lsusb | grep CS9711

# 1. Install runtime deps (IMPORTANT)
# sudo pacman -S fprintd opencv

# 2. Install patched libfprint
# yay -S libfprint-cs9711-git --rebuild

# 3. Restart service
# sudo systemctl restart fprintd

# 4. Check status
# systemctl status fprintd

# 5. Enroll   # sudo fprintd-enroll $USER
# sudo fprintd-enroll -f left-index-finger zezinas

# Configuring PAM /etc/pam.d/
# sudo nano /etc/pam.d/sudo
# insert line first line below the #%PAM-1.0 header
# auth      sufficient    pam_fprintd.so



# /etc/pam.d/
# sudo nano /etc/pam.d/sudo #enable for terminal (sudo), first line below the #%PAM-1.0 header
# auth      sufficient    pam_fprintd.so
#
# sudo nano /etc/pam.d/system-local-login # Enable for Login & Lock Screen, at the top of the auth section
# auth      sufficient    pam_fprintd.so
#
# sudo nano /etc/pam.d/polkit-1 # (Optional) Enable for Polkit (GUI auth)
# auth      sufficient    pam_fprintd.so


# fprintd-list
# fprintd-verify
# fprintd-delete
#
# sudo limine-snapper-restore
# sudo rm /var/lib/pacman/db.lck
# sudo pacman -Sy
