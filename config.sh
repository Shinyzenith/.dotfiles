#!/usr/bin/env bash
cd ~/.config/wayland-river
for dir in $( find .config -maxdepth 2 -mindepth 2 | awk -F "/" '{print $NF}')
do
	rm -rf ~/$dir
done

for dir in $(find .home -mindepth 2 -maxdepth 2 | awk -F "/" '{print $NF}')
do
	rm -rf ~/$dir
done

cd ~/.config/wayland-river/.config/
dots=$(ls -d */)
for dot in $dots
do
	stow -D "$dot" -t ~/.config
	stow "$dot" -t ~/.config
done

cd ~/.config/wayland-river/.home/
dots=$(ls -d */)
for dot in $dots
do
	stow -D "$dot" -t ~/
	stow "$dot" -t ~/
done

