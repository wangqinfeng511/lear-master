#!/bin/bash
#
if [ -e $1 ]; then
    echo "$1 is there."
else
    echo "no $1."
fi
