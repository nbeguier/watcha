#!/bin/bash

DEV=$1
PORTS='21,22,25,80,443,445,8080'
ESC=$(printf '\033')
BOLD="${ESC}[1m"
GREEN="${ESC}[92m"
YELLOW="${ESC}[93m"
BLUE="${ESC}[94m"
NATIVE="${ESC}[m"

# Test if DEV is defined
if [ -z "${DEV}" ]; then
    echo "$0 <interface>"
    echo "You have to define an interface :"

    ip a | grep -v "^ " | awk -F: '{print $2}'
    exit 1
fi

if [ ! -s /usr/bin/nmap ] || [ ! -s /usr/bin/ipcalc ] || [ ! -s /usr/bin/bc ] || [ ! -s /usr/bin/sudo ]; then
    echo "You have to install nmap, ipcalc, bc and sudo"
    exit 1
fi

source "$(dirname $0)"/functions/scan.sh
source "$(dirname $0)"/functions/link.sh
source "$(dirname $0)"/functions/help.sh

# SPOOF=$(get_rand_ip_simple)
# SPOOF=10.1.2.3
IP=$(get_ip)

# Stop if no IP
if [ -z "${IP}" ]; then
    echo "There is no IP address on this interface..."
    exit 1
fi

echo "${BOLD}Device${NATIVE}:     ${DEV}"
echo "${BOLD}IP${NATIVE}:         ${IP}"
echo "${BOLD}Network${NATIVE}:    $(get_network)"
echo "${BOLD}Spoofed IP${NATIVE}: ${SPOOF}"

# Stop if network to large
if [[ "$(get_subnetwork)" == *"Too much subnet"* ]]; then
    echo "Too much subnet..."
    echo "Do you want to reduce the network to a /24 ? (y/N)"
    read -r RESPONSE
    if [[ "${RESPONSE}" != *"y"* ]]; then
        exit 1
    fi
    # Redefinition of get_network
    function get_network {
        ipcalc -n "$(get_ip)" | grep 'Network:' | awk '{print $2}' | awk -F'/' '{print $1"/24"}'
    }
    function get_subnetwork {
        get_network
    }
    echo "${BOLD}Reduced network${NATIVE}:  $(get_network)"
fi

# SCAN
echo ""
echo "${BOLD}====SCAN====${NATIVE}"

scan_host

# LINK
echo ""
echo "${BOLD}====LINK====${NATIVE}"

link_22
link_80
link_443
link_445
link_8080

# HELP
echo ""
echo "${BOLD}====HELP====${NATIVE}"

help_22
help_80
help_443
help_445
help_8080
help_mac
