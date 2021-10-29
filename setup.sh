#!/usr/bin/env bash

# window manager minimum needs
sudo aura -S --needed --noconfirm dmenu
sudo aura -S --needed --noconfirm mako
sudo aura -S --needed --noconfirm stow
sudo aura -S --needed --noconfirm wlroots
sudo aura -S --needed --noconfirm xorg-xwayland
sudo aura -Aca --noconfirm river-git
sudo aura -Aca --noconfirm swaybg-git
sudo aura -Aca --noconfirm waybar-git

# OBS packages
sudo aura -Aca --noconfirm wlrobs-hg 
sudo aura -S --needed --noconfirm pipewire
sudo aura -S --needed --noconfirm obs-studio

# screenshot utilities
sudo aura -S --needed --noconfirm grim
sudo aura -S --needed --noconfirm slurp
sudo aura -S --needed --noconfirm wl-clipboard

#cleaning up orphans
sudo aura -Oj

mv ~/.config/mako ~/.config/mako-backup
mv ~/.config/river ~/.config/river-backup
mv ~/.config/waybar ~/.config/waybar-backup
cp wall.jpg /usr/share/backgrounds/wall.jpg
cd ~/.dotfiles/wayland
rm -rf ~/.gtkrc-2.0
rm -rf ~/.config/gtk-3.0
stow gtkrc-2.0 -t ~/
stow gtk-3.0 -t ~/.config
stow river -t ~/.config/
stow waybar -t ~/.config/
stow mako -t ~/.config/

#TODO: setup dmenu alternative, possibly rofi ( yikes )
#TODO: switch to the foot terminal?
