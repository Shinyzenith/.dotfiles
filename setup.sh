#!/usr/bin/env bash
# sleep , poweroff, reboot and otehr integrations https://wiki.artixlinux.org/Main/Elogind
# installing our package manager
doas pacman -S --noconfirm --needed git
if ! command -v paru &> /dev/null
then
	git clone https://aur.archlinux.org/paru-bin.git /tmp/paru-bin-cloned
	cd /tmp/paru-bin-cloned/
	makepkg -sfci --noconfirm --needed
fi
# arch linux support
doas pacman -S --noconfirm --needed artix-archlinux-support

cd ~/.config/.dotfiles
doas cp ./assets/pacman.conf /etc/pacman.conf
doas pacman -Syy


# makepkg.conf optimization
numberofcores=$(grep -c ^processor /proc/cpuinfo)
if [ $numberofcores -gt 1 ]
then
        doas sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j'$(($numberofcores+1))'"/g' /etc/makepkg.conf;
        doas sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -z - --threads=0)/g' /etc/makepkg.conf
        doas sed -i 's/COMPRESSZST=(zstd -c -z -q -)/COMPRESSZST=(zstd -c -z -q - --threads=0)/g' /etc/makepkg.conf
        doas sed -i "s/PKGEXT='.pkg.tar.xz'/PKGEXT='.pkg.tar.zst'/g" /etc/makepkg.conf
else
        echo "makepkg.conf not changed."
fi

for line in $(cat ./assets/packagelist)
do
	doas pacman -S --noconfirm --needed $line
done

for line in $(cat ./assets/aurlist)
do
	paru -S --noconfirm --needed $line
done

ln -s $(which doas) /usr/bin/doas
#cleaning up orphans
doas pacman -Rns --noconfirm scdoc
doas pacman -Rns --noconfirm python-pytest
doas pacman -Rdd --noconfirm xorg-server
doas pacman -Rdd --noconfirm foot-themes
doas pacman -S --needed wireplumber
paru -c --noconfirm
paru --gendb

doas ln -s /etc/runit/sv/bluetoothd /run/runit/service
doas ln -s /etc/runit/sv/sshd /run/runit/service

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
