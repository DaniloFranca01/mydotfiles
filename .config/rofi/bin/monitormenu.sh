#!/usr/bin/env bash

## Author  : Danilo França
## Mail    : danilo.franca01@gmail.com
## Github  : @Danilo.Franca01

dir=$HOME/.config/rofi/
styles=$dir/styles/
rofi_command="rofi -theme $styles/monitormenu.rasi"

# Options
monitor="度"
tv=" "
duplicar=" 度"
extender="度 度"

# Variable passed to rofi
options="$tv\n$monitor\n$duplicar\n$extender"

chosen="$(echo -e "$options" | $rofi_command -p -dmenu -selected-row 1)"
case $chosen in 
				$monitor) $HOME/Scripts/mymntr.sh -m ;;
				$tv) $HOME/Scripts/mymntr.sh -t ;;
				$duplicar) $HOME/Scripts/mymntr.sh -d ;;
				$extender) $HOME/Scripts/mymntr.sh -e ;;
esac
