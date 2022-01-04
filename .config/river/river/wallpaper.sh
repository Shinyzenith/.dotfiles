#!/usr/bin/env bash
killall swaybg
swaybg -i $(find /usr/share/backgrounds -type f| shuf | head -n 1) &
