# Arch App Installer

A simple no-Flatpak installer for Arch Linux and Arch-based distributions.

## Applications

- Spotify (`spotify`, not `spotify-launcher`)
- Telegram Desktop
- GIMP
- OBS Studio
- Proton VPN GUI
- LibreOffice Fresh
- Official Microsoft Visual Studio Code (`visual-studio-code-bin`)
- VLC
- Brave Browser
- Kdenlive

## Install

```bash
git clone https://github.com/Faris2k4/arch-app-installer.git
cd arch-app-installer
chmod +x install-apps.sh
./install-apps.sh
```

Run the script as your normal user, **not** with `sudo`. It installs `yay` automatically if neither `yay` nor `paru` is already installed.

This project does not install or use Flatpak.
