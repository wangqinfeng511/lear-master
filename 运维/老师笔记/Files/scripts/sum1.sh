#!/bin/bash
#
declare -i sum=0

for i in {1..100}; do
    echo "i is: $i."
    echo "sum is: $sum."
    let sum=$[$sum+$i]
done

echo "Sumary: $sum"
