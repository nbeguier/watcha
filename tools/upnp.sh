#!/bin/bash

# need to try this : gssdp-discover -i wlan0 --timeout=3

INET=$1

# unlock sudo
sudo ls >/dev/null

# Prepare the SSDP request
echo "M-SEARCH * HTTP/1.1
HOST: 239.255.255.250:1900
MAN: ssdp:discover
MX: 1
ST: ssdp:all" > /tmp/ssdp_discover.txt

# Listen interface to get the responses
sudo tcpdump -i any -u -n -A -s0 'port 1900' 1>/tmp/trace 2>/dev/null &

# Send the SSDP request
nc -b "${INET}" -w 1 -uvv 239.255.255.250 1900 >/dev/null < /tmp/ssdp_discover.txt

echo "Be patient, wait a minute... (Ctrl+C to stop)"
echo "After the run, you could try a 'tools/upnp_help.sh'"
tail -f /tmp/trace | grep -A8 -B1 NOTIFY | grep '^Location\|^Server\|^Name'

wait
