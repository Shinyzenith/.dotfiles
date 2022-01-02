killall swaybg
swaybg -i $(find /usr/share/backgrounds -type f| shuf | head -n 1) &
killall wlsunset
coords="${XDG_CACHE_HOME:-$HOME/.cache}/coords"
if [[ ! -f $coords ]];then
	curl "https://json.geoiplookup.io/$(curl https://ipinfo.io/ip)" > $coords
fi
wlsunset -l $(echo $coords | jq -r .latitude) -L $(echo $coords | jq -r .longitude) &
if [[ ! $(pgrep wireplumber) ]];then
	wireplumber & # trying this in .zprofile breaks my audio setup for some reason.
fi
bash /usr/share/backgrounds/roll.sh &
killall mako
mako &
killall waybar
waybar &
bash ~/.config/bin/gtktheme
killall polkit-gnome-authentication-agent-1
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# Set and exec into the default layout generator, rivertile.
# River will send the process group of the init executable SIGTERM on exit.
riverctl default-layout rivertile &
exec rivertile -main-ratio 0.5 -view-padding 5 -outer-padding 8 &
for pad in $(riverctl list-inputs | grep -i touchpad )
do
  riverctl input $pad events enabled
  riverctl input $pad tap enabled
done
light -S $(light -G)
killall nm-applet
nm-applet --indicator &
