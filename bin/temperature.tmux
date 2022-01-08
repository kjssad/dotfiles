#!/usr/bin/env bash

temp_string=$(sensors | grep -E '^Core [0-9]+' | awk '{sum+=$3; n+=1}; END {printf("%2.0f", sum/n)}')

fg_sec="#c3c3c6"
red="#f25e72"

if [[ $temp_string -gt 59 ]]; then
	color="$red"
else
	color="$fg_sec"
fi
echo "#[bold,fg=$color]$temp_stringºC"
