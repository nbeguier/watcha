#!/bin/bash

# unlock sudo
sudo ls >/dev/null

sudo tcpdump -i any -u -n 1>/tmp/trace 2>/dev/null &

echo "Be patient, wait a minute... (Ctrl+C to stop)"
echo "After the run, you could try a 'tools/listener_help.sh'"

wait
