export MOZ_ENABLE_WAYLAND=1
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export XKB_DEFAULT_OPTIONS=caps:swapescape
export GTK_USE_PORTAL=0
if [[ "$(tty)" = "/dev/tty1" ]]; then
	river &
fi
