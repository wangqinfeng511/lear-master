#!/bin/bash
#
declare -i usercount=0

for i in {1..10}; do
    if ! id user$i &> /dev/null; then
	useradd user$i
	echo user$i | passwd --stdin user$i &> /dev/null
	let usercount++
	echo "add user user$i finished."
    fi
done

echo "Total user added: $usercount."
