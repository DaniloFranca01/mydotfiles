kill -9 $(xprop | grep _NET_WM_PID | awk '{print $3}' | xargs ps h -o pid | awk '{print $1}') && aplay --device=pulse --quiet ~/Scripts/sounds/gunshot.wav
