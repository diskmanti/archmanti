#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
MONITORS=$(xrandr --query | grep " connected" | cut -d" " -f1)

# MONITORS=$MONITORS polybar top &
# MONITOR=$MONITORS polybar bottom;
echo "---" | tee -a /tmp/polybar_bottom.log
MONITOR=$MONITORS polybar bottom 2>&1 | tee -a /tmp/polybar_bottom.log & disown

echo "Bars launched..."