#!/bin/bash

# Update the system
sudo pacman -Syu

essential_packages=(hyprland qt5-wayland qt6-wayland xdg-desktop-portal-hyprland cliphist xdotools kitty firefox dolphin rofi dunst grim slurp hyprlock wl-clipboard fastfetch blueman udiskie pavucontrol zsh flatpak gtk-engine-murrine unzip scrcpy imagemagick stow openssh tree neovim)

aur_packages=(waybar-cava wlogout swaylock-effects pywal swappy swwww oh-my-posh mission-center impression nwg-look otf-font-awesome-6.6.0-1 ttf-jetbrains-mono-nerd ttf-cascadia-mono-nerd adobe-source-han-sans-jp-fonts)

flatpak_packages=(com.github.tchx84.Flatseal)

# Install packages

echo "Installing packages."
echo "Installing pacman packages."

sudo pacman -S --noconfirm "${essential_packages}"

echo "Done installing pacman packages!"
echo "Installing AUR packages."

paru -S --noconfirm "${aur_packages}"

echo "Done installing AUR packages!"
echo "Installing flatpak packages."

for app in "${flatpak_packages[@]}"; do
  flatpak install -y "$app"
done

echo "Done installing flatpak packages!"
echo "Installation stage complete."
echo "Using stow to set up symlinks from ~/dotfiles to ~/.config"

stow .

echo "Done setting up config symlinks."
echo "Copying over assets."

cp -r "~/dotfiles/.config/assets/sugar-candy" "/usr/share/sddm/themes"
cp "~/dotfiles/.config/assets/default.conf" "/usr/lib/sddm/sddm.conf.d/default.conf"

echo "Done copying assets."
echo "Starting up systemctl services"

systemctl_services=(sddm.service NetworkManager.service sshd.service polkit.service dbus-broker.service udisks2.service upower.service)

for service in "${systemctl_services[@]}"; do
  systemctl start "$service"
  echo "Started $service."
done

echo "Done starting services!"
echo "Enabling services."

for service in "${systemctl_services[@]}"; do
  systemctl enable "$service"
  echo "Enabled $service."
done

echo "Dotfiles installation complete."
echo "You may now reboot."



