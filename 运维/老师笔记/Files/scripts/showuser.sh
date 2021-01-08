#!/bin/bash
#
user=nginx

if id $user &> /dev/null; then
   #echo "ID: $(id -u $user)"
    userid=`id -u $user`
    echo "$user's is $userid."
fi
