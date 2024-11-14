#!/bin/bash

# Update the system
sudo pacman -Syu

essential_packages=(hyprland qt5-wayland qt6-wayland xdg-desktop-portal-hyprland qt5-graphicaleffects qt5-quickcontrols2 qt5-svg sddm cliphist xdotool kitty firefox dolphin rofi dunst grim slurp hyprlock wl-clipboard fastfetch blueman udiskie pavucontrol zsh flatpak gtk4 gtk-engine-murrine unzip scrcpy imagemagick stow openssh tree neovim)

aur_packages=(waybar-cava wlogout swaylock-effects pywal swappy swww oh-my-posh mission-center impression network-manager-applet nwg-look tokyonight-gtk-theme-git otf-font-awesome-6.6.0-1 ttf-jetbrains-mono-nerd ttf-cascadia-mono-nerd adobe-source-han-sans-jp-fonts)

flatpak_packages=(com.github.tchx84.Flatseal)

# Install packages

echo "Installing packages."
echo "Installing pacman packages."

sudo pacman -S "${essential_packages[@]}"

echo "Done installing pacman packages!"
echo "Installing AUR packages."

for app in "${aur_packages[@]}"; do
  paru -S "$app"
done

echo "Done installing AUR packages!"
echo "Installing flatpak packages."

for app in "${flatpak_packages[@]}"; do
  flatpak install -y "$app"
done

echo "Done installing flatpak packages!"
echo "Installation stage complete."
echo "Changing default shell."

if ! chsh -s "$(which zsh)"; then
  echo "Failed to set zsh as the default shell"
else
  echo "Successfully changed default shell."
fi

echo "Using stow to set up symlinks from ~/dotfiles to ~/.config"

stow .

echo "Setting up wallpaper and color scheme"
swww img "$HOME/Wallpapers/1.png" && wal -i "$HOME/Wallpapers/1.png"

echo "Done setting up config symlinks."
echo "Copying over assets."

usr=$(whoami)

sudo cp -r "$HOME/dotfiles/.config/assets/sugar-candy" "/usr/share/sddm/themes"
sudo chown -R "$usr" "/usr/share/sddm/themes/sugar-candy"

sudo cp "$HOME/dotfiles/.config/assets/default.conf" "/usr/lib/sddm/sddm.conf.d/default.conf"

echo "Done copying assets."
echo "Starting up systemctl services"

systemctl_services=(NetworkManager.service sshd.service sddm.service)

for service in "${systemctl_services[@]}"; do
  systemctl enable "$service"
  echo "Enabled $service."
done

for service in "${systemctl_services[@]}"; do
  systemctl start "$service"
  echo "Started $service."
done

echo "Done starting and enabling services!"

echo "Dotfiles installation complete."
echo "You may now reboot."



