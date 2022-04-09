#! /bin/sh
xsetroot -cursor_name left_ptr &
nvidia-settings --load-config-only &
dunst &
nm-applet &
~/Scripts/runPasystray.sh
feh --bg-fill ~/Imagens/Wallpapers/arch.png &
~/Scripts/compon.sh picom &
