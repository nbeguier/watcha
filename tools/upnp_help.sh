#!/bin/bash

echo "Sort Location:"
echo "--------------"
grep '^Location:' /tmp/trace | sort -u
echo "Help: curl -svLk  --connect-timeout 2 --max-time 2 -A \"\" LOCATION"

echo ""
echo "Sort Name:"
echo "----------"
grep '^Name:' /tmp/trace | sort -u

echo ""
echo "Sort Server:"
echo "----------"
grep '^Server:' /tmp/trace | sort -u

echo ""
echo "Sort source IP:"
echo "---------------"
grep ' UDP' /tmp/trace  | awk '{print $3}' | sort -u
