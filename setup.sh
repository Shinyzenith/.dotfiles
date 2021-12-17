#!/usr/bin/env bash
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

cd ~/.config/.dotfiles
sudo cp ./assets/pacman.conf /etc/pacman.conf
sudo pacman -Syy

for line in $(cat ./assets/packagelist)
do
	sudo pacman -S --noconfirm --needed $line
done

for line in $(cat ./assets/aurlist)
do
	sudo aura -Aca --noconfirm $line
done

#cleaning up orphans
sudo pacman -Rns --noconfirm scdoc
sudo pacman -Rdd --noconfirm xorg-server
sudo pacman -Rdd --noconfirm foot-themes
sudo aura -Oj --noconfirm

sudo ln -s /etc/runit/sv/bluetoothd /run/runit/service
sudo ln -s /etc/runit/sv/sshd /run/runit/service

xdg-user-dirs-update &
cd ~/.config/.dotfiles
sudo mkdir /usr/share/btop/themes
sudo cp ./assets/tokyo.theme /usr/share/btop/themes/tokyo.theme
./config.sh
sudo python3 -m pip install neovim
sudo python3 -m pip insall beautifulsoup4
sudo npm install neovim --global
sudo npm install prettier --global
mkdir -p ~/Pictures/screenshots
mkdir -p ~/Videos/recordings
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim -c :PlugInstall -c :exit :exit
nvim -c :PlugInstall -c :exit :exit
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
rm -rf ~/.npm
loginctl reboot
