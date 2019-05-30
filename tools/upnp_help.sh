#!/bin/bash

echo "Sort Location:"
echo "--------------"
grep -i '^Location:' /tmp/trace | sort -u
echo "Help: curl -svLk  --connect-timeout 2 --max-time 2 -A \"\" LOCATION"

echo ""
echo "Sort Name:"
echo "----------"
grep -i '^Name:' /tmp/trace | sort -u

echo ""
echo "Sort Server:"
echo "----------"
grep -i '^Server:' /tmp/trace | sort -u

echo ""
echo "Sort source IP:"
echo "---------------"
grep -i ' UDP' /tmp/trace  | awk '{print $3}' | sort -u
