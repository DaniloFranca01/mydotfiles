echo "######################### XMONAD DIRECTORY #####################"
pushd $HOME/.config/xmonad/
echo "######################### PULL XMONAD-DBUS #####################"
pushd $HOME/.config/xmonad/xmonad-dbus-git/ &&
				git pull && popd &&
echo "######################### PULL XMONAD-CONTRIB ##################"
pushd $HOME/.config/xmonad/xmonad-contrib-git/ &&
				git pull && popd &&
echo "######################### PULL XMONAD ##########################"
pushd $HOME/.config/xmonad/xmonad-git/ &&
				git pull && popd &&
echo "######################### UPGRADE STACK ########################"
stack upgrade &&
echo "######################### UPDATE STACK #########################"
stack install &&
popd &&
echo "######################### RECOMPILE/RESTART XMONAD #############"
xmonad --recompile && xmonad --restart
echo "######################### END ##################################"
