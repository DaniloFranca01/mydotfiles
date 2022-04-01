#!/bin/bash

case $1 in
  "picom") exec picom --config ~/.config/picom/picom.conf & ;;
  "xcompmgr") xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55 & ;;
esac
