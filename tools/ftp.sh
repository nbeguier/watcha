#!/bin/bash

ipaddress=$1
login=$2
password=$3

function check_binary() {
    if ! command -v "${1}" >/dev/null; then echo "You have to install $1"; exit 1; fi
}

check_binary lftp

lftp -u "${login}","${password}" -e "dir;quit" "${ipaddress}"
