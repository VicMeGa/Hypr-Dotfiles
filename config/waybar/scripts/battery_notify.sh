#!/bin/bash
PERCENT=$1
STATUS=$2

if [ "$STATUS" = "Discharging" ]; then
    if [ "$PERCENT" -le 5 ]; then
        notify-send -u critical "⚠️ Danger very low Battery" "Queda $PERCENT%"
    elif [ "$PERCENT" -le 20 ]; then
        notify-send -u normal "🔋 Low Battery" "Queda $PERCENT%"
    fi
fi

## chmod +x battery_notify.sh