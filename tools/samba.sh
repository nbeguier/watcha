#!/bin/bash

ipaddress=$1

function check_binary() {
    if ! command -v "${1}" >/dev/null; then echo "You have to install $1"; exit 1; fi
}

check_binary smbclient

smbclient -L //"${ipaddress}" -U guest --no-pass >/dev/null && echo smbclient //"${ipaddress}"/\<Sharename\> -U guest --no-pass
