export MOZ_ENABLE_WAYLAND=1
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export XKB_DEFAULT_OPTIONS=caps:swapescape
export GTK_USE_PORTAL=0
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
/usr/bin/pipewire-media-session &
if [[ "$(tty)" = "/dev/tty1" ]]; then
	river &
fi
