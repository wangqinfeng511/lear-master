#!/bin/bash
#
dir=/tmp/test

if ! [ -d $dir ]; then
    mkdir $dir
fi

for file in /etc/fstab /etc/hello /etc/rc.d/rc.sysinit; do
    if [ -f $file ]; then
	cp $file $dir
    fi
done
