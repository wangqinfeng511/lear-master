#!/bin/bash
#
declare -i sum=0

for ((i=1;i<=100;i++)); do
    if [ $[$i%2] -eq 0 ]; then
	let sum+=$i
    fi
done

echo "Sum: $sum."
