#!/usr/bin/env bash

battery="/org/freedesktop/UPower/devices/battery_BAT0"
state=$(upower -i "$battery" | grep 'state' | awk '{print $2}')
percentage=$(upower -i "$battery" | grep 'percentage' | awk '{print $2}' | cut -d"%" -f1)

fg_sec="#c3c3c6"
red="#f25e72"
green="#87de74"

if [[ $percentage -lt 43 ]]; then
	color="$red"
elif [[ $percentage -gt 77 && "$state" = 'charging' ]]; then
	color="$green"
else
	color="$fg_sec"
fi

if [[ "$state" = 'charging' ]]; then
	state='⚡'
else
	state=''
fi

echo "$state#[bold,fg=$color]$percentage%"
