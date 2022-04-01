#!/usr/bin/env bash

data=$(date +%Y-%m-%d_%H:%M:%S)
diretorio=~/Imagens/Screenshots/
nome=Screenshot
formato=.png
separador=-
saida=$diretorio$nome$separador$data$formato

case $1 in
  "u")
    exec maim -u $saida &
	;;
  "s")
    exec maim -s $saida &
	;;
  "i")
    exec maim -u -i $(xdotool getactivewindow) $saida &
	;;
esac

dunstify "[$nome]" "[$nome$separador$data$formato]\n[Salvo em:$diretorio]" -u low
