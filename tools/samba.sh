#!/bin/bash

ipaddress=$1

function check_binary() {
    which $1 >/dev/null
    if [ $? -ne 0 ]; then echo "You have to install $1"; exit 1; fi
}

check_binary smbclient

smbclient -L //"${ipaddress}" -U guest --no-pass >/dev/null && echo smbclient //"${ipaddress}"/\<Sharename\> -U guest --no-pass
