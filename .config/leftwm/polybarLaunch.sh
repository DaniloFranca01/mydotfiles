#!/usr/bin/env bash
killall -q polybar
SCRIPTPATH=$HOME/.config/leftwm/
index=0
monitors="$(polybar -m | sed s/:.*//)"
leftwm-state -q -n -t $SCRIPTPATH/sizes.liquid | sed -r '/^\s*$/d' | while read -r width x y
do
  let indextemp=index+1
  monitor=$(sed "$indextemp!d" <<<"$monitors")
  barname="mainbar"$index
  monitor=$monitor offset=$x width=$width polybar -c $SCRIPTPATH/polybar.config $barname &> /dev/null &
  let index=indextemp
done
