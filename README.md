# Installation

This repo contains my dotfiles configuration aswell as a installation script.

## Requirements

These are the packages you require to have before installing my dotfiles.

### Arch linux minimal install with multilib enabled in the pacman.conf file

### Update your system
Checks if everything is up-to date.
```
sudo pacman -Syu
```

### git
git is what we are gonna use to pull github repositories.
```
sudo pacman -S git
```

### base-devel
base-devel enables us to install aur packages.
```
sudo pacman -S base-devel
```

### paru
Paru is going to be our aur helper. An aur helper just essentially installs packages from the aur easier.
```
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

## Clone my dotfiles

### Clone and install
IMPORTANT: If you have a nvidia graphics card you will be prompted to install the nvidia drivers. Download those and follow the nvidia instructions further down when the installation is completed.
```
git clone https://github.com/N0TNAWA/dotfiles
cd dotfiles
chmod +x install.sh
./install.sh
```

## Nvidia drivers
Generate initramfs
```
sudo nano /etc/mkinitcpio.conf
```
Edit where you see 'MODULES=()' and add
```
MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
```
Assuming that you are using GRUB boot you wanna make some changes in /etc/default/grub
```
sudo nano /etc/default/grub
```
And edit where you see 'GRUB_CMDLINE_LINUX_DEFAULT=""' and add
```
GRUB_CMDLINE_LINUX_DEFAULT="nvidia_drm.modeset=1"
```
Now we want to automatically update the drivers whenever we update the system. To do that we need to create a hook
```
sudo mkdir /etc/pacman.d/hooks
sudo nano /etc/pacman.d/hooks/nvidia.hook
```
In this new file we wanna add these lines
```
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia

[Action]
Depends=mkinitcpio
When=PostTransaction
Exec=/usr/bin/mkinitcpio -P
```
these lines just tells the drviers to update whenever /usr/bin/mkinitcpio -P is executed. Which happens every update.

Now if you did everything right you should now only need to reboot.
