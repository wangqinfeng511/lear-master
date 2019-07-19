#!/bin/bash
#
declare -i max=$1
declare -i min=$1

if [ $# -lt 1 ]; then
    echo "1 paramter."
    exit 1
fi

for number in $*; do
    if [ $number -gt $max ]; then
	max=$number
    fi

    if [ $number -lt $min ]; then
 	min=$number
    fi
done

echo "Max number is $max." 
echo "Min number is $min." 
