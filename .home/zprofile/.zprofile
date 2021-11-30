if [ -d "$HOME/.config/bin" ] ;
  then PATH="$HOME/.config/bin:$PATH"
fi

if [ -d "$HOME/.config/bin" ] ;
  then PATH="$HOME/.config/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

export MOZ_ENABLE_WAYLAND=1
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=river
export XDG_CONFIG_HOME=$HOME/.config/
export XDG_CURRENT_DESKTOP=river
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export _JAVA_AWT_WM_NONREPARENTING=1
export XKB_DEFAULT_OPTIONS=caps:swapescape
export GTK_USE_PORTAL=0
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export CUDA_CACHE_PATH="${XDG_CACHE_HOME:-$HOME/.cache}/nv"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="${XDG_CONFIG_HOME:-$HOME/.config}/java"
timestamp=$(date +%F-%R)
/usr/bin/pipewire 2>/tmp/pipewire-${timestamp}.log &
/usr/bin/pipewire-pulse 2>/tmp/pipewire-pulse-${timestamp}.log &
/usr/bin/pipewire-media-session 2>/tmp/pipewire-media-session-${timestamp}.log &
curl "https://json.geoiplookup.io/$(curl https://ipinfo.io/ip)" > /tmp/coords

if [[ -z $WAYLAND_DISPLAY && $(tty) = "/dev/tty1" ]]; then
	exec dbus-run-session river -log-level debug > /tmp/river-${timestamp}.log 2>&1
fi
