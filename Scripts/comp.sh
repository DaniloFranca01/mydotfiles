#!/bin/bash

compositor="picom"
COMP_ID=$(pgrep $compositor)

if [ -n "${COMP_ID}" ]; then
  kill -9 $COMP_ID
  dunstify "[$compositor]" "["$compositor" OFF]" -u normal 
else
  ~/Scripts/compon.sh "$compositor"
  dunstify "[$compositor]" "["$compositor" ON]" -u low 
fi
