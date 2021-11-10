#!/bin/bash
set -e

type -p 'sshd' &>/dev/null || printf "error: Could not find 'sshd', Make sure you have openssh installed.\n"
ssh-keygen -t rsa -b 4096 -C "aakashsensharma@gmail.com"

echo "################################################################"
echo "################### Generated ssh key"
echo "################################################################"

eval "$(ssh-agent -s)"
echo "################################################################"
echo "################### Started ssh agent"
echo "################################################################"

ssh-add ~/.ssh/id_rsa
echo "################################################################"
echo "################### Added the ssh-key to the keychain"
echo "################################################################"

wl-copy < ~/.ssh/id_rsa.pub
echo "################################################################"
echo "################### The key has been copied to your clipboard. Upload this to github."
echo "################################################################"
