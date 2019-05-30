#!/bin/bash

function help_22 {
    if grep -q '22/OPEN/ssh' /tmp/.watcha.output; then
        echo "${YELLOW}SSH help:${NATIVE}"
    fi
    for ipaddress in $(grep '22/OPEN/ssh' /tmp/.watcha.output | awk '{print $1}')
    do
        if $VERBOSE; then echo ">> " curl -sLk --connect-timeout 2 --max-time 2 -A '""' http://"${ipaddress}":22/ 2>/dev/null; fi
        echo "    ${ipaddress}  ==> ${BLUE}$(curl -sLk --connect-timeout 2 --max-time 2 -A \"\" http://"${ipaddress}":22/ 2>/dev/null)${NATIVE}"
    done
}

function help_80 {
    if grep -q '80/OPEN/http' /tmp/.watcha.output; then
        echo "${YELLOW}HTTP help:${NATIVE}"
    fi
    for ipaddress in $(grep '80/OPEN/http' /tmp/.watcha.output | awk '{print $1}')
    do
        if $VERBOSE; then echo ">> " curl -sILk  --connect-timeout 2 --max-time 2 -A '""' http://"${ipaddress}":80/ "| grep 'Server: ' | tail -1"; fi
        echo "    http://${ipaddress}:80/  ==> ${BLUE}$(curl -sILk  --connect-timeout 2 --max-time 2 -A \"\" http://"${ipaddress}":80/ | grep 'Server: ' | tail -1)${NATIVE}"
    done
}

function help_443 {
    if grep -q '443/OPEN/https' /tmp/.watcha.output; then
        echo "${YELLOW}HTTPS help:${NATIVE}"
    fi
    for ipaddress in $(grep '443/OPEN/https' /tmp/.watcha.output | awk '{print $1}')
    do
        if $VERBOSE; then echo ">> " curl -sILk  --connect-timeout 2 --max-time 2 -A '""' https://"${ipaddress}":443/ "| grep 'Server: ' | tail -1"; fi
        echo "    https://${ipaddress}:443/  ==> ${BLUE}$(curl -sILk --connect-timeout 2 --max-time 2 -A \"\" https://"${ipaddress}":443/ | grep 'Server: ' | tail -1)${NATIVE}"
        if $VERBOSE; then echo ">> " curl -vsk  --connect-timeout 2 --max-time 2 -A '""' https://"${ipaddress}":443/ " 2>&1 >/dev/null | grep 'subject: ' | tail -1"; fi
        echo "    https://${ipaddress}:443/  ==> ${BLUE}$(curl -vsk --connect-timeout 2 --max-time 2 -A \"\" https://"${ipaddress}":443/ 2>&1 >/dev/null | grep 'subject: ' | tail -1)${NATIVE}"
    done
}

function help_445 {
    if grep -q '445/OPEN/microsoft-ds' /tmp/.watcha.output; then
        echo "${YELLOW}SAMBA help:${NATIVE}"
    fi
    for ipaddress in $(grep '445/OPEN/microsoft-ds' /tmp/.watcha.output | awk '{print $1}')
    do
        if $VERBOSE; then echo ">> " smbclient -L //"${ipaddress}" -U guest --no-pass; fi
        echo "    smbclient -L //${ipaddress} -U guest --no-pass  ==> $(smbclient -L //"${ipaddress}" -U guest --no-pass >/dev/null 2>&1 && echo -e "${GREEN}" smbclient //"${ipaddress}"/\<Sharename\> -U guest --no-pass)${NATIVE}"
    done
}

function help_2049 {
    if grep -q '2049/OPEN/nfs' /tmp/.watcha.output; then
        echo "${YELLOW}NFS help:${NATIVE}"
    fi
    for ipaddress in $(grep '2049/OPEN/nfs' /tmp/.watcha.output | awk '{print $1}')
    do
        if $VERBOSE; then echo ">>  showmount -e ${ipaddress}"; fi
        echo "    showmount -e ${ipaddress}  ==> ${BLUE}$(showmount -e ${ipaddress})${NATIVE}"
    done
}

function help_8080 {
    if grep -q '8080/OPEN/http-proxy' /tmp/.watcha.output; then
        echo "${YELLOW}HTTP-PROXY help:${NATIVE}"
    fi
    for ipaddress in $(grep '8080/OPEN/http-proxy' /tmp/.watcha.output | awk '{print $1}')
    do
        if $VERBOSE; then echo ">> " curl -sILk  --connect-timeout 2 --max-time 2 -A '""' http://"${ipaddress}":8080/ "| grep 'Server: ' | tail -1"; fi
        echo "    http://${ipaddress}:8080/  ==> ${BLUE}$(curl -sILk --connect-timeout 2 --max-time 2 -A \"\" http://"${ipaddress}":8080/ | grep 'Server: ' | tail -1)${NATIVE}"
    done
}

function help_9000 {
    if grep -q '9000/OPEN/cslistener' /tmp/.watcha.output; then
        echo "${YELLOW}Port 9000 help:${NATIVE}"
    fi
    for ipaddress in $(grep '9000/OPEN/cslistener' /tmp/.watcha.output | awk '{print $1}')
    do
        if $VERBOSE; then echo ">> " curl -sILk  --connect-timeout 2 --max-time 2 -A '""' http://"${ipaddress}":9000/ "| grep 'Server: ' | tail -1"; fi
        echo "    http://${ipaddress}:9000/  ==> ${BLUE}$(curl -sILk --connect-timeout 2 --max-time 2 -A \"\" http://"${ipaddress}":9000/ | grep 'Server: ' | tail -1)${NATIVE}"
        if $VERBOSE; then echo ">> " curl -sILk  --connect-timeout 2 --max-time 2 -A '""' https://"${ipaddress}":9000/ "| grep 'Server: ' | tail -1"; fi
        echo "    https://${ipaddress}:9000/  ==> ${BLUE}$(curl -sILk --connect-timeout 2 --max-time 2 -A \"\" https://"${ipaddress}":9000/ | grep 'Server: ' | tail -1)${NATIVE}"
        if $VERBOSE; then echo ">> " curl -vsk  --connect-timeout 2 --max-time 2 -A '""' https://"${ipaddress}":9000/ " 2>&1 >/dev/null | grep 'subject: ' | tail -1"; fi
        echo "    https://${ipaddress}:9000/  ==> ${BLUE}$(curl -vsk --connect-timeout 2 --max-time 2 -A \"\" https://"${ipaddress}":9000/ 2>&1 >/dev/null | grep 'subject: ' | tail -1)${NATIVE}"
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
            if $VERBOSE; then echo ">> " sudo nmap -sS -Pn -n -S "${SPOOF}" -e "${DEV}" "${ipaddress}" -p 1 "| grep 'MAC Address: '"; fi
            sudo nmap -sS -Pn -n -S "${SPOOF}" -e "${DEV}" "${ipaddress}" -p 1 | grep 'MAC Address: '
        else
            if $VERBOSE; then echo ">> " sudo nmap -sS -Pn -n "${ipaddress}" -p 1 "| grep 'MAC Address: '"; fi
            sudo nmap -sS -Pn -n "${ipaddress}" -p 1 | grep 'MAC Address: '
        fi
    done
}
