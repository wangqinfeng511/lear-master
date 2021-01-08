#!/bin/bash
#
declare -i usercount=0

for i in {1..10}; do
    if id user$i &> /dev/null; then
	echo "user$i exists."
    else
	useradd user$i
        echo user$i | passwd --stdin user$i &> /dev/null
        let usercount++
        echo "ADD user$i finished."
    fi
done

echo "Add users: $usercount."
