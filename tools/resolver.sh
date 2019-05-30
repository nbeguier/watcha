#!/bin/bash

NETWORK=${1:-192.168.0}   

function resolve {
    IP=$1
    RESOLVED=$(dig -x "${IP}" -p 5353 @224.0.0.251 +short +time=0 2>/dev/null | grep .local)
    if [ "${RESOLVED}" != "" ]; then
        echo "${IP}" '<=>' "${RESOLVED}"
    fi 
}

for i in $(seq 1 64)
do
    resolve "${NETWORK}.${i}" &
done

wait

for i in $(seq 65 128)
do
    resolve "${NETWORK}.${i}" &
done

wait

for i in $(seq 129 192)
do
    resolve "${NETWORK}.${i}" &
done

wait

for i in $(seq 193 255)
do
    resolve "${NETWORK}.${i}" &
done

wait
