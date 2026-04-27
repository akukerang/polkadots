#!/usr/bin/env fish

echo "Installing pacman packages..."
pacman -S --needed --noconfirm \
    hyprland hyprpaper hyprlock hypridle hyprpolkitagent \
    kitty dolphin \
    waybar wlogout swaync \
    yay flatpak \
    networkmanager blueman \
    github-cli fastfetch \
    steam libreoffice-still bitwarden firefox discord \

echo "Installing AUR packages..."
yay -S --needed --aur --noconfirm \
    visual-studio-code-bin \
    hyprshade \
    bitwarden \
    ttf-cascadia-code-nerd \
    ttf-cascadia-mono-nerd \
    ttf-nerd-fonts-symbols  \
    ttf-nerd-fonts-symbols-common  \
    ttf-jetbrains-mono-nerd  

echo "Installing flatpak packages..."
flatpak install -y com.spotify.Client

# Copy dots into /home
echo "Copying dotfiles..."
cp ~/polkadots/Desktop/.*  ~/

echo "Setup complete. Reboot"