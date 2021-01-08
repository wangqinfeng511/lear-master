#!/bin/bash
#
if [ $# -lt 1 ]; then
    echo "Plz input 1 paramenter at least."
    exit 1
fi

for user in $@; do
    if ! id $user &> /dev/null; then
    	echo "No such user."
 	exit 2
    fi

    if [ $(id -u $user) -eq $(id -g $user) ]; then
	echo -n "UID same as GID: "
	echo -n "$user"
    	echo
    fi
done
