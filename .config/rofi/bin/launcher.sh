#!/usr/bin/env bash

theme="launcher.rasi"
dir="$HOME/.config/rofi/styles/"

rofi -no-lazy-grab -show drun -modi drun -theme $dir/"$theme"
