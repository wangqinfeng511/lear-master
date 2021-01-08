#!/bin/bash
#
declare -i loginshell=0
declare -i nologin=0

for shell in $(cut -d: -f7 /etc/passwd); do
    if [ "$shell" == '/sbin/nologin' ]; then
	let nologin++
    else
	let loginshell++
    fi
done

echo "Login Shell Users: $loginshell, No login Shell Users: $nologin."
