#!/usr/bin/env bash
# sleep , poweroff, reboot and otehr integrations https://wiki.artixlinux.org/Main/Elogind

# setting shell to zsh.
sudo sed -i "s/^$USER\(:x:$(id -u $USER)\)\(.*\)\/bin\/\w*/$USER\1\2\/bin\/zsh/g" /etc/passwd

# installing our package manager
sudo pacman -S --noconfirm --needed git
if ! command -v aura &> /dev/null
then
	git clone https://aur.archlinux.org/aura-bin.git /tmp/aura-git-cloned
	cd /tmp/aura-git-cloned/
	makepkg -sfci --noconfirm --needed
fi

# arch linux support
sudo aura -S --needed --noconfirm artix-archlinux-support

# enabling chaotic
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm --needed

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
#sudo aura -S --noconfirm --needed ntfs-3g
sudo aura -S --noconfirm --needed mlocate
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
sudo aura -S --noconfirm --needed brightnessctl
sudo aura -S --noconfirm --needed xdg-user-dirs
sudo aura -Aca --noconfirm discord-canary-electron-bin
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
sudo aura -S --noconfirm --needed lib32-nvidia-utils 
sudo aura -S --noconfirm --needed lib32-vulkan-icd-loader
sudo aura -S --noconfirm --needed lib32-vulkan-icd-loader
sudo aura -S --noconfirm --needed lib32-vulkan-intel 
sudo aura -S --noconfirm --needed mesa
sudo aura -S --noconfirm --needed nvidia
sudo aura -S --noconfirm --needed nvidia-prime
sudo aura -S --noconfirm --needed nvidia-settings
sudo aura -S --noconfirm --needed nvidia-utils
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
sudo aura -S --noconfirm --needed imagemagick

sudo aura -Aca --noconfirm cursor-theme-macos-big-sur
sudo aura -Aca --noconfirm gotop-bin
#sudo aura -Aca --noconfirm moc-pulse
sudo aura -Aca --noconfirm nerd-fonts-complete
sudo aura -S --noconfirm --needed ttf-jetbrains-mono
sudo aura -S --noconfirm --needed ttf-nerd-fonts-symbols
sudo aura -Aca --noconfirm nordic-darker-theme
sudo aura -Aca --noconfirm otf-san-francisco
sudo aura -S --noconfirm --needed zsh-autosuggestions
sudo aura -S --noconfirm --needed zsh-syntax-highlighting
sudo aura -S --noconfirm --needed qutebrowser
sudo aura -S --noconfirm --needed network-manager-applet
sudo aura -S --noconfirm --needed networkmanager
sudo aura -Aca --noconfirm  oh-my-zsh-git
sudo aura -S --noconfirm --needed yt-dlp
sudo aura -S --noconfirm papirus-icon-theme


# wayland setup
sudo aura -S --needed --noconfirm foot
sudo aura -Aca --noconfirm rofi-lbonn-wayland-git
sudo aura -Aca --noconfirm rivercarro-git
#sudo aura -Aca --noconfirm kile-wl
sudo aura -S --needed --noconfirm mako
sudo aura -S --needed --noconfirm stow
sudo aura -S --needed --noconfirm wlroots
sudo aura -S --needed --noconfirm xorg-xwayland
sudo aura -Aca --noconfirm river-git
sudo aura -Aca --noconfirm swaybg-git
sudo aura -Aca --noconfirm waybar-git

# OBS packages
sudo aura -S --needed --noconfirm qt5-wayland
sudo aura -S --needed --noconfirm pipewire
sudo aura -S --needed --noconfirm obs-studio

# screenshot utilities
sudo aura -S --needed --noconfirm grim
sudo aura -S --needed --noconfirm slurp
sudo aura -S --needed --noconfirm wl-clipboard

#cleaning up orphans
sudo pacman -Rns --noconfirm scdoc
sudo pacman -Rdd --noconfirm xorg-server
sudo aura -Oj --noconfirm

xdg-user-dirs-update
cd ~/.dotfiles
sudo mkdir /usr/share/backgrounds
sudo cp ./wallpapers/* /usr/share/backgrounds/
./config.sh
sudo python3 -m pip install neovim
sudo python3 -m pip insall beautifulsoup4
sudo npm install neovim --global
mkdir -p ~/.bin
mkdir -p ~/.vim/undodir
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
sudo chown root /usr/share/icons/default/index.theme
sudo gpasswd -a $USER video
sudo gpasswd -a $USER power
sudo gpasswd -a $USER audio
loginctl reboot

#TODO: setup dmenu alternative, possibly rofi ( yikes )
