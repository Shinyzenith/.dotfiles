
killall swaybg
swaybg -i /usr/share/backgrounds/wall.jpg &
killall mako
mako &
killall waybar
waybar &
bash ~/.config/bin/gtktheme
killall polkit-gnome-authentication-agent-1
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
killall nm-applet
nm-applet --indicator &
# Set and exec into the default layout generator, rivertile.
# River will send the process group of the init executable SIGTERM on exit.
riverctl default-layout rivertile &
exec rivertile -main-ratio 0.5 -view-padding 5 -outer-padding 8 &
for pad in $(riverctl list-inputs | grep -i touchpad )
do
  riverctl input $pad events enabled
  riverctl input $pad tap enabled
done
light -S 50%
