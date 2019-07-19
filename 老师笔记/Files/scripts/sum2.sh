#!/bin/bash
#
declare -i evensum=0
declare -i oddsum=0

for i in $(seq 2 2 100); do
    let evensum+=$i
done

for i in $(seq 1 2 100); do
    let oddsum+=$i
done

echo "Even sum: $evensum."
echo "Odd sum: $oddsum."
