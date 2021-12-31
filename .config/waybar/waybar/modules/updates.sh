#!/usr/bin/env bash
pkg_updates() {
  updates=$(checkupdates | wc -l)
  if [ $updates == 0 ]; then
    :
  elif [ $updates == 1 ]; then
    echo -n " 1 Update"
  else
    echo -n " $updates Updates"
  fi

  aurupdates=$(paru -Qua | wc -l)
  if [ $aurupdates == 0 ]; then
    :
  elif [ $updates == 1 ]; then
    echo ", 1 AUR Update"
  else
    echo -n ", $updates AUR Updates"
  fi
}
pkg_updates
