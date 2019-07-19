#!/bin/bash

groupname=newgroup2
username=stu2
dirpath=/tmp/hellobash2

groupadd -g 8089 $groupname
useradd -u 5056 -G $groupname $username

mkdir $dirpath
cp /etc/rc.d/rc.sysinit $dirpath
