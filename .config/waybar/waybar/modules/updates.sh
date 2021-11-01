#!/usr/bin/env bash
pkg_updates() {
	updates=$(checkupdates | wc -l)
  if [ $updates == 0 ]; then
    echo " Fully Updated"
  else
    echo " $updates updates"
  fi
}
echo "$(pkg_updates)"
