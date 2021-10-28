#!/usr/bin/env bash
killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if [[ $(xrandr --listmonitors | rg DP-2) ]]; then
  echo "hi"
  export PRIMARY_MONITOR=DP-2-1
  export SECONDARY_MONITOR=DP-2-3
  export ETHERNET_ADAPTER=enp0s13f0u1u1

  polybar main-bar &
  polybar secondary-bar &
else
  echo "okay"
  export PRIMARY_MONITOR=eDP-1
  export ETHERNET_ADAPTER=enp0s31f6

  polybar main-bar &
fi

echo "Bars launched..."
