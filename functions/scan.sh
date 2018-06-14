#!/bin/bash

function get_ip {
    ip a show dev "${DEV}" | grep 'inet ' | awk '{print $2}'
}

function get_ip_simple {
    get_ip | awk -F/ '{print $1}'
}

function get_rand_ip_simple {
    get_ip_simple | awk -F. '{print $1"."$2"."$3".1"}'
}

function get_network {
    ipcalc -n "$(get_ip)" | grep 'Network:' | awk '{print $2}'
}

function get_n_24 {
    SUBNET_SIZE=$1
    if [ "${SUBNET_SIZE}" -ge 24 ]; then
        echo 1
    else
        echo 2 ^ \(24 - "${SUBNET_SIZE}"\) | bc
    fi
}

function get_subnetwork {
    NETMASK=$(get_ip | awk -F/ '{print $2}')
    N_24=$(get_n_24 "${NETMASK}")
    if [ "${N_24}" -gt 32 ]; then
        echo "Too much subnet"
        exit 1
    elif [ "${N_24}" -ne 1 ]; then
        IPCALC_ARGS=
        for _ in $(seq "${N_24}")
        do
            IPCALC_ARGS=$(echo $IPCALC_ARGS 24)
        done
        ipcalc -n "$(get_network)" "${IPCALC_ARGS}" | grep 'Network: ' | awk '{print $2}' | tail -$N_24
    else
        get_network
    fi
}

function scan_host {
    echo "" > /tmp/.watcha.output
    echo "... tail -f /tmp/.watcha.output"
    for subnet in $(get_subnetwork)
    do
        if [ -n "${SPOOF}" ]; then
            sudo nmap -sS -p "${PORTS}" -Pn -n -S "${SPOOF}" -e "${DEV}" -oG /tmp/.watcha.subnet "${subnet}" >/dev/null
        else
            sudo nmap -sS -p "${PORTS}" -Pn -n -oG /tmp/.watcha.subnet "${subnet}" >/dev/null
        fi
        grep -v ^# /tmp/.watcha.subnet | grep 'Ports:' | awk '{$1=""; $3=""; $4=""; print $0}' | 
            sed "s#closed/tcp/#closed#g" |
            sed "s#filtered/tcp/#filtered#g" |
            sed "s#open/tcp/#OPEN#g" |
            sed "s#///##g" >> /tmp/.watcha.output
    done
    sudo rm -f /tmp/.watcha.subnet
    sed "s#OPEN#${GREEN}OPEN${NATIVE}#g" /tmp/.watcha.output
}
