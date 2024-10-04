#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
# polybar-msg cmd quit
# Otherwise you can use the nuclear option:
killall -q polybar

# Launch polybar
MONITORS=$(xrandr --query | grep " connected" | cut -d" " -f1)

echo "---" | tee -a /tmp/mainbar-i3.log

MONITORS=$MONITORS polybar mainbar-i3  2>&1 | tee -a /tmp/mainbar-i3.log & disown

echo "Bars launched..."