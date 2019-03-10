#!/bin/bash

# need to try this : gssdp-discover -i wlan0 --timeout=3

inet=$1

# unlock sudo
sudo ls >/dev/null

echo "-SEARCH * HTTP/1.1
HOST: 239.255.255.250:1900
MAN: ssdp:discover
MX: 10
ST: ssdp:all" > /tmp/ssdp_discover.txt

sudo tcpdump -i any -u -n -A -s0 'port 1900' > /tmp/trace 2>/dev/null &

nc -b "$inet" -w 1 -uvv 239.255.255.250 1900 >/dev/null < /tmp/ssdp_discover.txt


echo "Be patient, wait a minute... (Ctrl+C to stop)"
tail -f /tmp/trace | grep -A8 -B1 NOTIFY | grep '^Location\|^Server\|^Name'

wait
