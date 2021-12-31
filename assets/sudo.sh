#!/usr/bin/env bash
# script to run as root before running setup.sh
# setting doas to work without password.
echo "permit nopass :wheel" | tee /etc/doas.conf
