#!/usr/bin/env bash
killall swaybg
setsid -f swaybg -i $(find /usr/share/backgrounds -type f| shuf | head -n 1) &
