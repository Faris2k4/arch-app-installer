#!/usr/bin/env bash

set -Eeuo pipefail

if [[ ! -f /etc/arch-release ]]; then
    echo "Error: This script is intended for Arch Linux or an Arch-based distribution."
    exit 1
fi

if [[ "$EUID" -eq 0 ]]; then
    echo "Error: Do not run this script as root. Run it as your normal user."
    exit 1
fi

if ! command -v sudo >/dev/null 2>&1; then
    echo "Error: sudo is required."
    exit 1
fi

AUR_HELPER=""
if command -v yay >/dev/null 2>&1; then
    AUR_HELPER="yay"
elif command -v paru >/dev/null 2>&1; then
    AUR_HELPER="paru"
fi

echo "Updating the system..."
sudo pacman -Syu --needed --noconfirm

echo "Installing build requirements..."
sudo pacman -S --needed --noconfirm base-devel git

if [[ -z "$AUR_HELPER" ]]; then
    echo "No AUR helper found. Installing yay..."
    temp_dir="$(mktemp -d)"
    trap 'rm -rf "$temp_dir"' EXIT

    git clone https://aur.archlinux.org/yay.git "$temp_dir/yay"
    (
        cd "$temp_dir/yay"
        makepkg -si --noconfirm
    )

    AUR_HELPER="yay"
fi

official_packages=(
    telegram-desktop
    gimp
    obs-studio
    libreoffice-fresh
    vlc
    kdenlive
)

aur_packages=(
    spotify
    proton-vpn-gtk-app
    visual-studio-code-bin
    brave-bin
)

echo "Installing official Arch packages..."
sudo pacman -S --needed --noconfirm "${official_packages[@]}"

echo "Installing AUR packages..."
"$AUR_HELPER" -S --needed --noconfirm "${aur_packages[@]}"

echo
echo "Installation complete. No Flatpak packages were installed."
