#!/bin/bash
# ~/.config/niri/notify-volume.sh

volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo "true" || echo "false")

if [ "$muted" = "true" ]; then
    icon="󰝟"
    text="Вимкнено"
else
    if [ "$volume" -lt 33 ]; then
        icon="󰕿"
    elif [ "$volume" -lt 66 ]; then
        icon="󰖀"
    else
        icon="󰕾"
    fi
    text="${volume}%"
fi

notify-send -a volume -h string:x-canonical-private-synchronous:volume -h int:value:$volume "$icon Гучність" "$text"