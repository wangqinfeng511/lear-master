#!/bin/bash
#
declare -i evensum=0
declare -i oddsum=0

for ((i=1;i<=100;i++)); do
    if [ $[$i%2] -eq 1 ]; then
   	let oddsum+=$i
    else
	let evensum+=$i
    fi
done

echo "EvenSum: $evensum, OddSum: $oddsum."
