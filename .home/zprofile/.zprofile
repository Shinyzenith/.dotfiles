export MOZ_ENABLE_WAYLAND=1
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export XKB_DEFAULT_OPTIONS=caps:swapescape
if [[ "$(tty)" = "/dev/tty1" ]]; then
	river
fi
