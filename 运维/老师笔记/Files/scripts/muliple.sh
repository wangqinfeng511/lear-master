#!/bin/bash
#
for i in {1..9}; do
    for j in {1..9}; do
	if [ $i -ge $j ]; then
	    echo -n "${j}X${i}=$[$i*$j]	"
        fi
    done
    echo
done

