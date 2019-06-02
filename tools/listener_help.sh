#!/bin/bash

echo "Source hosts:"
echo "============="
grep ' IP ' /tmp/trace | awk '{print $3}' | awk -F. '{print $1"."$2"."$3"."$4}' | awk -F: '{print $1}' | sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4 -u

echo ''

echo "Destination hosts:"
echo "=================="
grep ' IP ' /tmp/trace | awk '{print $5}' | awk -F. '{print $1"."$2"."$3"."$4}' | awk -F: '{print $1}' | sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4 -u
