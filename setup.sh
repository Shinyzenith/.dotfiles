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


# makepkg.conf optimization
numberofcores=$(grep -c ^processor /proc/cpuinfo)
if [ $numberofcores -gt 1 ]
then
        sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j'$(($numberofcores+1))'"/g' /etc/makepkg.conf;
        sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -z - --threads=0)/g' /etc/makepkg.conf
        sudo sed -i 's/COMPRESSZST=(zstd -c -z -q -)/COMPRESSZST=(zstd -c -z -q - --threads=0)/g' /etc/makepkg.conf
        sudo sed -i "s/PKGEXT='.pkg.tar.xz'/PKGEXT='.pkg.tar.zst'/g" /etc/makepkg.conf
else
        echo "makepkg.conf not changed."
fi

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
sudo pacman -Rns --noconfirm python-pytest
sudo pacman -Rdd --noconfirm xorg-server
sudo pacman -Rdd --noconfirm foot-themes
sudo pacman -Rdd --noconfirm sudo
doas ln -s /usr/bin/doas /usr/bin/sudo
doas pacman -S --needed wireplumber
doas aura -Oj --noconfirm

doas ln -s /etc/runit/sv/bluetoothd /run/runit/service
sudo ln -s /etc/runit/sv/sshd /run/runit/service

xdg-user-dirs-update &
cd ~/.config/.dotfiles
doas mkdir /usr/share/btop/themes
doas cp ./assets/tokyo.theme /usr/share/btop/themes/tokyo.theme
./config.sh
doas python3 -m pip install neovim
doas python3 -m pip insall beautifulsoup4
doas npm install neovim --global
doas npm install prettier --global
mkdir -p ~/Pictures/screenshots
mkdir -p ~/Videos/recordings
mkdir -p ~/.local/share/vimwiki
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim -c :PlugInstall -c :exit :exit
nvim -c :PlugInstall -c :exit :exit
doas mkdir -p /usr/share/icons/default
doas touch /usr/share/icons/default/index.theme
doas chown $USER /usr/share/icons/default/index.theme
doas chown $USER /usr/share/backgrounds
doas echo "[Icon Theme]" > /usr/share/icons/default/index.theme
doas echo "Inherits=macOSBigSur" >> /usr/share/icons/default/index.theme
doas chown root /usr/share/icons/default/index.theme
doas gpasswd -a $USER video
doas gpasswd -a $USER power
doas gpasswd -a $USER audio
#bash ~/.config/.dotfiles/assets/advcpmv.sh
rm -rf ~/.npm
echo "DO NOT FORGET TO GO TO chrome://flags and ENABLE webrtc pipewire"
