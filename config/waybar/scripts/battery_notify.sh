#!/bin/bash
PERCENT=$1
STATUS=$2

if [ "$STATUS" = "Discharging" ]; then
    if [ "$PERCENT" -le 5 ]; then
        notify-send -u critical "⚠️ Batería muy baja" "Queda $PERCENT%"
    elif [ "$PERCENT" -le 20 ]; then
        notify-send -u normal "🔋 Batería baja" "Queda $PERCENT%"
    fi
fi

## chmod +x battery_notify.sh