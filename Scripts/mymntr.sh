if [ "$1" == "-m" ]; then
  xrandr --output DVI-I-0 --off --output DVI-D-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-0 --off --output HDMI-1 --off --output DP-1 --off
elif [ "$1" == "-t" ]; then
  xrandr --output DVI-I-0 --off --output HDMI-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DVI-D-0 --off --output DVI-D-1 --off --output DP-1 --off 
elif [ "$1" == "-d" ]; then
  xrandr --output HDMI-0 --same-as DVI-D-0
elif [ "$1" == "-e" ]; then
  xrandr --output HDMI-0 --left-of DVI-D-0
else
  echo -e "-m  -- monitor\n-t  -- tv\n-d  -- duplicar tela\n-e  -- extender tela"
fi
