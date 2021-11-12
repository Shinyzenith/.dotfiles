#!/usr/bin/env bash
pkg_updates() {
	updates=$(pacman -Qu | wc -l)
  if [ $updates == 0 ]; then
    exit 0
  elif [ $updates == 1 ]; then
    echo " 1 Update"
  else
    echo " $updates Updates"
  fi
}
pkg_updates
