#!/usr/bin/env bash
set -e
# Haven't tested this script yet !!!!!
# have to update depdendency list
#part1
echo "For UEFI installs only."
cd ~/.dotfiles
loadkeys us
lsblk
echo "Enter the drive: "
read drive
cfdisk $drive 
echo "Enter the linux partition: "
read partition
mkfs.ext4 $partition 
echo "Enter boot partition: "
read bootpartition
mkfs.vfat -F 32 $bootpartition
mount $partition /mnt 
mkdir -p /mnt/boot
mount $bootpartition /mnt/boot
pacman -Sy --noconfirm --needed artix-archlinux-support
cp ./assets/pacman.conf /etc/pacman.conf
basestrap /mnt base base-devel linux linux-firmware linux-headers grub efibootmgr networkmanager networkmanager-runit runit elogind-runit
fstabgen -U /mnt >> /mnt/etc/fstab
sed '1,/^#part2$/d' artix_install.sh > /mnt/arch_install2.sh
chmod +x /mnt/artix_install2.sh
artix-chroot /mnt ./artix_install2.sh
exit 

#part2
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "Hostname: "
read hostname
echo $hostname > /etc/hostname
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >> /etc/hosts
passwd
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
sed -i "s/^.*#\(%wheel\sALL=(ALL) NOPASSWD: ALL\)/\1\nDefaults \!tty_tickets/g" /mnt/etc/sudoers
ln -s /etc/runit/sv/NetworkManager /etc/runit/runsvdir/current
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "Enter Username: "
read username
useradd -m -G wheel -s /bin/zsh $username
passwd $username
echo "Pre-Installation Finished Reboot now"
ai3_path=/home/$username/artix_install3.sh
sed '1,/^#part3$/d' artix_install2.sh > $ai3_path
chown $username:$username $ai3_path
chmod +x $ai3_path
su -c $ai3_path -s /bin/sh $username
exit 

#part3
sudo rm /artix_install2.sh
cd $HOME
# sleep , poweroff, reboot and otehr integrations https://wiki.artixlinux.org/Main/Elogind

# installing our package manager
sudo pacman -S --noconfirm --needed git
if ! command -v aura &> /dev/null
then
	git clone https://aur.archlinux.org/aura-bin.git /tmp/aura-git-cloned
	cd /tmp/aura-git-cloned/
	makepkg -sfci --noconfirm --needed
fi

# arch linux support
sudo aura -S --noconfirm --needed artix-archlinux-support

cd ~/.dotfiles
sudo cp ./assets/pacman.conf /etc/pacman.conf
sudo pacman -Syy

# pipewire stuff
sudo aura -S --noconfirm --needed pipewire
sudo aura -S --noconfirm --needed pipewire-alsa
sudo aura -S --noconfirm --needed pipewire-pulse
sudo aura -S --noconfirm --needed pipewire-jack
sudo aura -S --noconfirm --needed lib32-pipewire
sudo aura -S --noconfirm --needed lib32-pipewire-jack
sudo aura -S --noconfirm --needed xdg-desktop-portal-wlr
sudo aura -S --noconfirm --needed pulsemixer
# sudo aura -S --noconfirm --needed easyeffects
# sudo aura -S --noconfirm --needed helvum
# sudo aura -S --noconfirm --needed carla

# base package install
sudo aura -S --noconfirm --needed scdoc
sudo aura -S --noconfirm --needed bat
sudo aura -S --noconfirm --needed exa
sudo aura -S --noconfirm --needed zsh
sudo aura -S --noconfirm --needed mpv
#sudo aura -S --noconfirm --needed meld
sudo aura -S --noconfirm --needed btop
sudo aura -S --noconfirm --needed wget
sudo aura -Aca --noconfirm nsxiv
sudo aura -S --noconfirm --needed tmux
sudo aura -S --noconfirm --needed tldr
sudo aura -S --noconfirm --needed dkms
sudo aura -S --noconfirm --needed gtk2
sudo aura -S --noconfirm --needed gvfs # fs support for artix
sudo aura -S --noconfirm --needed gvfs-mtp
sudo aura -S --noconfirm --needed ntfs-3g
sudo aura -S --noconfirm --needed unzip
sudo aura -S --noconfirm --needed p7zip
sudo aura -S --noconfirm --needed expac
sudo aura -S --noconfirm --needed qt5ct
sudo aura -S --noconfirm --needed xclip
sudo aura -S --noconfirm --needed bluez
sudo aura -S --noconfirm --needed bluez-runit
sudo ln -s /etc/runit/sv/bluetoothd /run/runit/service
sudo aura -S --noconfirm --needed zenity
sudo aura -S --noconfirm --needed man-db
sudo aura -S --noconfirm --needed wmname
sudo aura -S --noconfirm --needed polkit
sudo aura -S --noconfirm --needed ranger
sudo aura -S --noconfirm --needed openssh
sudo ln -s /etc/runit/sv/sshd /run/runit/service
sudo aura -S --noconfirm --needed zathura
sudo aura -S --noconfirm --needed reflector
sudo aura -S --noconfirm --needed bitwarden
sudo aura -S --noconfirm --needed xarchiver
sudo aura -S --noconfirm --needed blueberry
sudo aura -S --noconfirm --needed playerctl
sudo aura -S --noconfirm --needed noto-fonts
sudo aura -S --noconfirm --needed dosfstools
sudo aura -S --noconfirm --needed bluez-utils
sudo aura -S --noconfirm --needed intel-ucode
sudo aura -S --noconfirm --needed kvantum-qt5
sudo aura -S --noconfirm --needed pcmanfm-gtk3
sudo aura -S --noconfirm --needed polkit-gnome
sudo aura -S --noconfirm --needed light
sudo aura -S --noconfirm --needed xdg-user-dirs
sudo aura -S --noconfirm --needed discord-canary
sudo aura -S --noconfirm --needed noto-fonts-emoji
sudo aura -S --noconfirm --needed zathura-pdf-mupdf
sudo aura -S --noconfirm --needed archlinux-keyring

sudo aura -S --noconfirm --needed adobe-source-han-serif-cn-fonts
sudo aura -S --noconfirm --needed adobe-source-han-serif-jp-fonts
sudo aura -S --noconfirm --needed adobe-source-han-serif-kr-fonts
sudo aura -S --noconfirm --needed adobe-source-han-serif-otc-fonts
sudo aura -S --noconfirm --needed adobe-source-han-serif-tw-fonts


sudo aura -S --noconfirm --needed bbswitch
sudo aura -S --noconfirm --needed intel-ucode
sudo aura -S --noconfirm --needed lib32-mesa
# sudo aura -S --noconfirm --needed lib32-nvidia-utils
sudo aura -S --noconfirm --needed lib32-vulkan-icd-loader
sudo aura -S --noconfirm --needed lib32-vulkan-icd-loader
sudo aura -S --noconfirm --needed lib32-vulkan-intel
sudo aura -S --noconfirm --needed mesa
# sudo aura -S --noconfirm --needed nvidia
# sudo aura -S --noconfirm --needed nvidia-prime
# sudo aura -S --noconfirm --needed nvidia-settings
# sudo aura -S --noconfirm --needed nvidia-utils
sudo aura -S --noconfirm --needed vulkan-icd-loader
sudo aura -S --noconfirm --needed vulkan-icd-loader
sudo aura -S --noconfirm --needed vulkan-intel
sudo aura -S --noconfirm --needed xf86-video-intel

sudo aura -S --noconfirm --needed npm
sudo aura -S --noconfirm --needed neovim
sudo aura -S --noconfirm --needed nodejs
sudo aura -S --noconfirm --needed python3
sudo aura -S --noconfirm --needed ripgrep
sudo aura -S --noconfirm --needed python-pip

#sudo aura -S --noconfirm --needed neofetch
sudo aura -S --noconfirm --needed zathura-ps
sudo aura -S --noconfirm --needed pacman-contrib
sudo aura -S --noconfirm --needed imagemagick

sudo aura -Aca --noconfirm cursor-theme-macos-big-sur
sudo aura -Aca --noconfirm gotop-bin
sudo aura -Aca --noconfirm moc-pulse
sudo aura -Aca --noconfirm nerd-fonts-complete
sudo aura -S --noconfirm --needed ttf-jetbrains-mono
sudo aura -S --noconfirm --needed ttf-nerd-fonts-symbols
sudo aura -Aca --noconfirm nordic-darker-theme
sudo aura -Aca --noconfirm otf-san-francisco
sudo aura -S --noconfirm --needed zsh-autosuggestions
sudo aura -S --noconfirm --needed zsh-syntax-highlighting
sudo aura -S --noconfirm --needed firefox
sudo aura -S --noconfirm --needed brave
sudo aura -S --noconfirm --needed network-manager-applet
sudo aura -S --noconfirm --needed networkmanager
sudo aura -Aca --noconfirm  oh-my-zsh-git
sudo aura -S --noconfirm --needed yt-dlp
sudo aura -S --noconfirm --needed papirus-icon-theme


# wayland setup
sudo aura -S --noconfirm --needed tokyo-night-gtk
sudo aura -S --noconfirm --needed tokyo-night-wallpapers
sudo aura -S --noconfirm --needed wlsunset
sudo aura -S --noconfirm --needed foot
sudo aura -Rns --noconfirm --needed foot-themes
sudo aura -Aca --noconfirm rofi-lbonn-wayland-git
sudo aura -Aca --noconfirm rivercarro-git
sudo aura -S --noconfirm --needed mako
sudo aura -S --noconfirm --needed stow
sudo aura -S --noconfirm --needed wlroots
sudo aura -S --noconfirm --needed xorg-xwayland
sudo aura -Aca --noconfirm river-git
sudo aura -Aca --noconfirm swaybg-git
sudo aura -Aca --noconfirm waybar-git

# OBS packages
sudo aura -S --noconfirm --needed qt5-wayland
sudo aura -S --noconfirm --needed pipewire
sudo aura -S --noconfirm --needed obs-studio

# screenshot utilities
sudo aura -S --noconfirm --needed grim
sudo aura -S --noconfirm --needed swappy
sudo aura -S --noconfirm --needed slurp
sudo aura -S --noconfirm --needed wl-clipboard

#cleaning up orphans
sudo pacman -Rns --noconfirm scdoc
sudo pacman -Rdd --noconfirm xorg-server
sudo aura -Oj --noconfirm

xdg-user-dirs-update
cd ~/.dotfiles
./config.sh
sudo python3 -m pip install neovim
sudo python3 -m pip insall beautifulsoup4
sudo npm install neovim --global
mkdir -p ~/Pictures/screenshots
mkdir -p ~/Videos/recordings
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
sudo mkdir -p /usr/share/icons/default
sudo touch /usr/share/icons/default/index.theme
sudo chown $USER /usr/share/icons/default/index.theme
sudo chown $USER /usr/share/backgrounds
sudo echo "[Icon Theme]" > /usr/share/icons/default/index.theme
sudo echo "Inherits=macOSBigSur" >> /usr/share/icons/default/index.theme
sudo cp -r ~/.dotfiles/usr/share/themes/TokyoNight /usr/share/themes/
sudo chown root /usr/share/icons/default/index.theme
sudo gpasswd -a $USER video
sudo gpasswd -a $USER power
sudo gpasswd -a $USER audio
sudo rm -rf /home/$USER/artix_install3.sh
loginctl reboot
