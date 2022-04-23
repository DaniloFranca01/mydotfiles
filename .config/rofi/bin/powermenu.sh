#!/usr/bin/env bash

dir=$HOME/.config/rofi                                                                    
styles=$dir/styles                                                                        
rofi_command="rofi -theme $styles/powermenu.rasi"                                         

uptime=$(uptime -p | sed -e 's/up //g')                                                   
cpu=$($dir/bin/usedcpu)
memory=$($dir/bin/usedram)

# Options
shutdown=""
reboot=""
lock=""
suspend="⏾"
logout=""

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "祥  $uptime  |     $cpu  |  ﬙  $memory " -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
        systemctl poweroff
    ;;
    $reboot)
		    systemctl reboot
    ;;
    $lock)
		    if [[ -f /usr/bin/i3lock ]]; then
			    i3lock
		    elif [[ -f /usr/bin/betterlockscreen ]]; then
		  	  betterlockscreen --lock
				fi
    ;;
    $suspend)
        mpc -q pause
			  amixer set Master mute
			  systemctl suspend
		;;
    $logout)
		    if [[ "$DESKTOP_SESSION" == "qtile" ]]; then
			  	exec killall qtile
			  elif [[ "$DESKTOP_SESSION" == "xmonad" ]]; then
		  		exec killall xmonad-x86_64-linux
			  elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
			  	bspc quit
			  elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
			  	i3-msg exit
			  fi
    ;;
esac
