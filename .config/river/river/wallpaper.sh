#!/usr/bin/env bash
swaybg_instances=$(ps axh | grep swaybg | grep -v grep | awk '{print $1}')
setsid -f swaybg -i $(find /usr/share/backgrounds -type f| shuf | head -n 1)
sleep 1 # for a smooth transition with no flicker
for instance in $swaybg_instances; do
	kill -9 $instance 1>/dev/null 2>&1
done
