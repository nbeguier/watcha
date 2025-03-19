#!/bin/bash
# Check for interface argument
if [ -z "$1" ]; then
  echo "Usage: $0 <interface>"
  echo "You could specify the interface for tcpdump (e.g., eth0, wlan0)."
  exit 1
fi
INTERFACE=$1
# unlock sudo
sudo ls >/dev/null
sudo tcpdump -i "$INTERFACE" -u -n 1>/tmp/trace 2>/dev/null &
echo "Be patient, wait a minute... (Ctrl+C to stop)"
echo "After the run, you could try a 'tools/listener_help.sh'"
wait
