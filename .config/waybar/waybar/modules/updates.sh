#!/usr/bin/env bash
pkg_updates() {
  updates=$(checkupdates | wc -l)
  if [ $updates == 1 ]; then
    echo -n " 1 Update "
  elif [ $updates -ne 0 ];then
    echo -n " $updates Updates "
  fi

  aurupdates=$(paru -Qua | wc -l)
  if [ $aurupdates == 1 ]; then
    echo -n " 1 AUR Update"
  elif [ $aurupdates -ne 0 ];then
    echo -n " $aurupdates AUR Updates"
  fi
}
pkg_updates
