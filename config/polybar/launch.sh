#!/usr/bin/env bash

if type polybar > /dev/null 2>&1; then
    # Terminate already running bar instances
    killall -q polybar

    # Wait until the processes have been shut down
    while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

    polybar top &
else
    # Terminate already running bar instances
    killall -q waybar

    # Wait until the processes have been shut down
    while pgrep -u $UID -x waybar >/dev/null; do sleep 1; done
    waybar &
fi
