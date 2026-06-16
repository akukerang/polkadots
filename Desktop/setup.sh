#!/usr/bin/env fish

if test (id -u) -eq 0
    echo "This script should NOT be run as root. Please run as normal user."
    exit 1
end

echo "Installing pacman packages..."
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm \
    hyprland hyprpolkitagent hyprshot \
    kitty dolphin archlinux-xdg-menu \
    yay \
    networkmanager blueman \
    github-cli fastfetch btop \
    steam libreoffice-still helium-browser-bin \
    discord zen-browser-bin bitwarden \
    nwg-look rofi noctalia-shell \
    ttf-cascadia-mono-nerd \
    ttf-nerd-fonts-symbols \
    ttf-nerd-fonts-symbols-common \
    ttf-jetbrains-mono-nerd  

echo "Installing AUR packages..."
yay -S --needed --aur --noconfirm \
    visual-studio-code-bin \
    spotify \
    qt6ct-kde

# Spicetify
curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R

# Copying dotfiles
echo "Copying dotfiles..."
cp ~/polkadots/Desktop/.*  ~/

xdg-settings set default-web-browser firefox.desktop

echo "Setup complete. Todo:"
echo "1. Reboot"
echo "2. Open Spotify and login:"
echo "  spicetify backup apply"
echo "3. gh auth login"

