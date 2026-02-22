#!/bin/bash
# ~/.config/niri/notify-brightness.sh

current=$(brightnessctl get)
max=$(brightnessctl max)
percent=$((current * 100 / max))

if [ "$percent" -lt 33 ]; then
    icon="󰃞"
elif [ "$percent" -lt 66 ]; then
    icon="󰃟"
else
    icon="󰃠"
fi

notify-send -a brightness -h string:x-canonical-private-synchronous:brightness -h int:value:$percent "$icon Яскравість" "${percent}%"