#!/bin/bash

INET=$1

if [ -z "${INET}" ]; then
    echo "Usage: $0 <INET>"
    exit 1
fi

function check_binary() {
    if ! command -v "${1}" >/dev/null; then echo "You have to install $1"; exit 1; fi
}

check_binary ip

# unlock sudo
sudo ls >/dev/null

echo ">>SPOOF MAC"
echo "${BOLD}$(ip link show "${INET}" | grep ether)${NATIVE}"
echo "will become ..."
ip link set dev "${INET}" address random
echo "${BOLD}$(ip link show "${INET}" | grep ether)${NATIVE}"

ip link set dev "${INET}" down

ip link set dev "${INET}" up
