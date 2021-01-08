#!/bin/bash
#
host=$(hostname)

if [ "$host" == 'localhost' ]; then
    echo 'www.magedu.com' > /proc/sys/kernel/hostname
    echo "The hostname is: $(hostname)."
else
    echo "The hostname is: $host."
fi
