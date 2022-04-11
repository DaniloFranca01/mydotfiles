#!/usr/bin/env bash

data=$(date +%Y-%m-%d_%H:%M:%S)
diretorio=~/Imagens/Screenshots/
nome=Screenshot
formato=.png
separador=-
saida=$diretorio$nome$separador$data$formato

case $1 in
  "u")
    maim -u $saida
		;;
  "s")
    maim -s $saida
		;;
  "i")
    maim -u -i $(xdotool getactivewindow) $saida
		;;
esac

if [ $? = 0 ]; then 
  dunstify "[$nome]" "[$nome$separador$data$formato]\n[Salvo em:$diretorio]" -u low
fi
