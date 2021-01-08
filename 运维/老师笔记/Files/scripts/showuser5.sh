#!/bin/bash
#
userid=$(id -u $1)

if [ $userid -eq 0 ]; then
    echo "admin"
elif [ $userid -gt 0 -a $userid -lt 500 ]; then
    echo "sys user, id is $userid"
else
    echo "Common user, id is $userid"
fi
