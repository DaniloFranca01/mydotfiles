case $1 in
		"-m") xrandr --output DVI-D-0 --primary --mode 1920x1080 --output HDMI-0 --off
		;;
		"-t") xrandr --output HDMI-0 --primary --mode 1920x1080 --output DVI-D-0 --off 
		;;
		"-d") xrandr --output HDMI-0 --auto --same-as DVI-D-0 --output DVI-D-0 --auto
		;;
		"-e") xrandr --output HDMI-0 --auto --left-of DVI-D-0 --output DVI-D-0 --auto --primary
		;;
		"-h") echo -e "-m  -- monitor\n-t  -- tv\n-d  -- duplicar tela\n-e  -- extender tela\n-h  -- ajuda"
esac
