#! /bin/sh
xsetroot -cursor_name left_ptr &
$HOME/.config/polybar/launch.sh &
sleep 1
dunst &
nm-applet &
$HOME/Scripts/runPasystray.sh
feh --bg-fill $HOME/Imagens/Wallpapers/arch.png &
$HOME/Scripts/compon.sh picom &
ssh-add -q $HOME/.ssh/id_rsa $HOME/.ssh/id_ed25519
