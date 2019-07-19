#!/bin/bash
#
hname=$(hostname)

if [ -z "$hname" -o "$hname" == "(none)" -o "$hname" == "localhost" ]; then
    hostname mail.magedu.com
else
    echo "The hostname is: $hname."
fi
