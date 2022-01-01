#!/usr/bin/env bash
# script to run as root before running setup.sh
# setting doas to work without password.
pacman -S opendoas --noconfirm --needed
pacman -Rdd sudo --noconfirm
echo "permit nopass :wheel" | tee /etc/doas.conf
chown -c root:root /etc/doas.conf
chmod -c 0400 /etc/doas.conf
ln -s $(which doas) /usr/bin/doas
