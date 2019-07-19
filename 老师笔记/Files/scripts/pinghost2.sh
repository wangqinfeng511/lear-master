#!/bin/bash
#
for ((i=1;i<=20;i++)); do
    if ping -w 1 -c 1 172.16.100.$i &> /dev/null; then
	echo -e "\033[32m172.16.100.$i\033[0m is up."
    else
	echo -e "\033[31m172.16.100.$i\033[0m is down."
    fi
done
