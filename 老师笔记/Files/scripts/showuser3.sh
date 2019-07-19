#!/bin/bash
#
if [ $# -lt 1 ]; then
    echo "Plz input a parament."
    exit 2
fi

if ! id $1 &> /dev/null; then
    echo "No such user."
    exit 1
fi

userid=$(id -u $1)

if [ $userid -ge 500 ]; then
    echo "$1 is a comman user."
fi
