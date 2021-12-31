#!/usr/bin/env bash
# script to run as root before running setup.sh
# setting doas to work without password.
echo "permit nopass :wheel" | tee /etc/doas.conf
chown -c root:root /etc/doas.conf
chmod -c 0400 /etc/doas.conf
