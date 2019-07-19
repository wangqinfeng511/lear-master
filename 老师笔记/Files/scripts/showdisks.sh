#!/bin/bash
#
if ! [[ "$1" =~ ^/dev/[sh]d[a-z]$ ]]; then
   echo "Not a device file."
   exit 1
fi

if fdisk -l /dev/[hs]d[a-z] | grep "^Disk" | grep "$1" &> /dev/null; then
    fdisk -l $1
else
    echo "No such disk."
fi
