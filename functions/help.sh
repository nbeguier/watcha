#!/bin/bash

function help_22 {
    if grep -q '22/OPEN/ssh' /tmp/.watcha.output; then
        echo "${YELLOW}SSH help:${NATIVE}"
    fi
    for ipaddress in $(grep '22/OPEN/ssh' /tmp/.watcha.output | awk '{print $1}')
    do
        echo "    ${ipaddress}  ==> ${BLUE}$(curl -sLk --connect-timeout 2 --max-time 2 -A \"\" http://"$ipaddress":22/ 2>/dev/null)${NATIVE}"
    done
}

function help_80 {
    if grep -q '80/OPEN/http' /tmp/.watcha.output; then
        echo "${YELLOW}HTTP help:${NATIVE}"
    fi
    for ipaddress in $(grep '80/OPEN/http' /tmp/.watcha.output | awk '{print $1}')
    do
        echo "    http://${ipaddress}:80/  ==> ${BLUE}$(curl -sILk  --connect-timeout 2 --max-time 2 -A \"\" http://"$ipaddress":80/ | grep 'Server: ' | tail -1)${NATIVE}"
    done
}

function help_443 {
    if grep -q '443/OPEN/https' /tmp/.watcha.output; then
        echo "${YELLOW}HTTPS help:${NATIVE}"
    fi
    for ipaddress in $(grep '443/OPEN/https' /tmp/.watcha.output | awk '{print $1}')
    do
        echo "    https://${ipaddress}:443/  ==> ${BLUE}$(curl -sILk --connect-timeout 2 --max-time 2 -A \"\" https://"$ipaddress":443/ | grep 'Server: ' | tail -1)${NATIVE}"
    done
}

function help_445 {
    if grep -q '445/OPEN/microsoft-ds' /tmp/.watcha.output; then
        echo "${YELLOW}SAMBA help:${NATIVE}"
    fi
    for ipaddress in $(grep '445/OPEN/microsoft-ds' /tmp/.watcha.output | awk '{print $1}')
    do
        echo "    smbclient -L //${ipaddress} -U guest --no-pass  ==> $(smbclient -L //"${ipaddress}" -U guest --no-pass >/dev/null 2>&1 && echo -e "${GREEN}" smbclient //"${ipaddress}"/\<Sharename\> -U guest --no-pass)${NATIVE}"
    done
}

function help_8080 {
    if grep -q '8080/OPEN/http-proxy' /tmp/.watcha.output; then
        echo "${YELLOW}HTTP-PROXY help:${NATIVE}"
    fi
    for ipaddress in $(grep '8080/OPEN/http-proxy' /tmp/.watcha.output | awk '{print $1}')
    do
        echo "    http://${ipaddress}:8080/  ==> ${BLUE}$(curl -sILk --connect-timeout 2 --max-time 2 -A \"\" http://"$ipaddress":8080/ | grep 'Server: ' | tail -1)${NATIVE}"
    done
}


function help_mac {
    if grep -q 'OPEN' /tmp/.watcha.output; then
        echo "${YELLOW}MAC help:${NATIVE}"
    fi
    for ipaddress in $(grep 'OPEN' /tmp/.watcha.output | awk '{print $1}')
    do
        echo "${ipaddress}"
        if [ -n "${SPOOF}" ]; then
            sudo nmap -sS -Pn -n -S "${SPOOF}" -e "${DEV}" "${ipaddress}" -p 1 | grep 'MAC Address: '
        else
            sudo nmap -sS -Pn -n "${ipaddress}" -p 1 | grep 'MAC Address: '
        fi
    done
}
