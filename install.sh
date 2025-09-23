#!/bin/bash

# Update the system
sudo pacman -Syu

essential_packages=(hyprland qt5-wayland qt6-wayland xdg-desktop-portal-hyprland qt5-graphicaleffects qt5-quickcontrols2 qt5ct qt6ct qt5-svg polkit-kde-agent kvantum kvantum-qt5 sddm cliphist playerctl xdotool kitty dolphin dunst grim slurp hyprlock wl-clipboard fastfetch blueman udiskie pavucontrol zsh flatpak gtk4 gtk-engine-murrine unzip scrcpy imagemagick stow openssh tree neovim polkit-kde-agent)

aur_packages=(waybar-cava rofi-emoji wlogout swaylock-effects zen-browser pywal swappy swww eww oh-my-posh pacman-contrib obs-studio spotify-launcher spicetify-cli network-manager-applet nwg-look otf-font-awesome-6.6.0-1 ttf-jetbrains-mono-nerd ttf-cascadia-mono-nerd adobe-source-han-sans-jp-fonts quickshell-git)

flatpak_packages=(com.github.tchx84.Flatseal io.missioncenter.MissionCenter io.gitlab.adhami3310.Impression)

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

read -p "Do you want to install wine?(Y/n): " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
  wine_packages=(wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader)
  
  sudo pacman -S "${wine_packages[@]}"

  echo "Installed wine successfully."

else
  echo "Skipping wine installation."
fi

read -p "Do you want to install nvidia drivers?(Y/n): " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
  nvidia_packages=(nvidia nvidia-utils nvidia-settings lib32-nvidia-utils nvidia-libgl lib32-nvidia-libgl vulkan-icd-loader lib32-vulkan-icd-loader libvdpau mesa vdpauinfo libglvnd libva libva-utils lib32-mesa lib32-libvdpau lib32-libva-vdpau-driver lib32-libglvnd lib32-libva)

  sudo pacman -S "${nvidia_packages[@]}"

  echo "Installed nvidia successfully.(After the installation, follow the instructions on the github page to set up automatic updates.)"

else
  echo "Skipping nvidia installation."
fi

echo "Done installing flatpak packages!"
echo "Installation stage complete."
echo "Changing default shell."

# change shell

if ! chsh -s "$(which zsh)"; then
  echo "Failed to set zsh as the default shell"
else
  echo "Successfully changed default shell."
fi

echo "Using stow to set up symlinks from ~/dotfiles to ~/.config"

# setting up symlinks between the dotfiles and the .config folder

stow .

echo "Setting up wallpaper and color scheme"

# setting up color scheme

swww img "$HOME/Wallpapers/Tree.jpeg"
wal -i "$HOME/Wallpapers/Tree.jpeg"

echo "Done setting up config symlinks."
echo "Copying over assets."

# setting up sddm

usr=$(whoami)

sudo cp -r "$HOME/dotfiles/.config/assets/sugar-candy" "/usr/share/sddm/themes"
sudo chown -R "$usr" "/usr/share/sddm/themes/sugar-candy"

sudo cp "$HOME/dotfiles/.config/assets/default.conf" "/usr/lib/sddm/sddm.conf.d/default.conf"

echo "Done copying assets."
echo "Starting up systemctl services"

# starting and enabling system services

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



