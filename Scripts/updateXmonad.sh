pushd $HOME/.config/xmonad/
pushd $HOME/.config/xmonad/xmonad-dbus-git/ &&
				git pull && popd &&
pushd $HOME/.config/xmonad/xmonad-contrib-git/ &&
				git pull && popd &&
pushd $HOME/.config/xmonad/xmonad-git/ &&
				git pull && popd &&
stack upgrade &&
stack install &&
popd &&
xmonad --recompile && xmonad --restart
