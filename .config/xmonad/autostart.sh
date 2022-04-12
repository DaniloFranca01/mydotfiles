#! /bin/sh
xsetroot -cursor_name left_ptr &
$HOME/.config/polybar/launch.sh &
nvidia-settings --load-config-only &
dunst &
nm-applet &
$HOME/Scripts/runPasystray.sh
feh --bg-fill $HOME/Imagens/Wallpapers/arch.png &
$HOME/Scripts/compon.sh picom &
