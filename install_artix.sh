#!/usr/bin/env bash

# pacman configs
sudo sed -i "s/^.*#Color/Color\nILoveCandy/g" /etc/pacman.conf
sudo sed -i "s/^.*#\(ParallelDownloads\).*$/\1 = 16/g" /etc/pacman.conf

# work in progress
