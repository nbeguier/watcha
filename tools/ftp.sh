#!/bin/bash

ipaddress=$1
login=$2
password=$3

function check_binary() {
    which $1 >/dev/null
    if [ $? -ne 0 ]; then echo "You have to install $1"; exit 1; fi
}

check_binary lftp

lftp -u "${login}","${password}" -e "dir;quit" "${ipaddress}"
