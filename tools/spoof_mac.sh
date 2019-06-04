#!/bin/bash

INET=$1
MAC=${2:-de:ad:be:ef:ff:ff}

if [ -z "${INET}" ]; then
    echo "Usage: $0 <INET> [<MAC>]"
    exit 1
fi

function check_binary() {
    if ! command -v "${1}" >/dev/null; then echo "You have to install $1"; exit 1; fi
}

check_binary ip

# unlock sudo
sudo ls >/dev/null

sudo ip link set dev "${INET}" down

echo ">>SPOOF MAC"
echo "${BOLD}$(ip link show "${INET}" | grep ether)${NATIVE}"
echo "will become ..."
sudo ip link set dev "${INET}" address "${MAC}"
echo "${BOLD}$(ip link show "${INET}" | grep ether)${NATIVE}"

sudo ip link set dev "${INET}" up
