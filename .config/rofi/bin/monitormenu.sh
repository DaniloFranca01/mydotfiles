#!/usr/bin/env bash

## Author  : Danilo França
## Mail    : danilo.franca01@gmail.com
## Github  : @Danilo.Franca01

dir=$HOME/.config/rofi/
styles=$dir/styles/
rofi_command="rofi -theme $styles/monitormenu.rasi"

# Options
tv=" "
monitor="度"
extender=" 度"
duplicar="度 度"

# Variable passed to rofi
options="$tv\n$monitor\n$extender\n$duplicar"

chosen="$(echo -e "$options" | $rofi_command -p -dmenu -selected-row 1)"
case $chosen in 
				$tv) $HOME/Scripts/mymntr.sh -t ;;
				$monitor) $HOME/Scripts/mymntr.sh -m ;;
				$extender) $HOME/Scripts/mymntr.sh -e ;;
				$duplicar) $HOME/Scripts/mymntr.sh -d ;;
esac
