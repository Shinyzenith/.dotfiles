#!/usr/bin/env bash
# script to run as sudo before installation.
# setting sudo to work without password.
sudo sed -i "s/^.*#\(%wheel\sALL=(ALL) NOPASSWD: ALL\)/\1\nDefaults \!tty_tickets/g" /etc/sudoers
