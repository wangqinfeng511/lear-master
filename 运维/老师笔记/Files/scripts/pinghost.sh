#!/bin/bash
#
for ((i=1;i<=20;i++)); do
    if ping -w 1 -c 1 172.16.100.$i &> /dev/null; then
	echo "172.16.100.$i is up."
    fi
done
