#!/bin/bash
#
#usershell=$(grep "^$1\>" /etc/passwd | cut -d: -f7)
grep "^$1\>.*sh$" /etc/passwd
retval=$?

if [ $(id -u $1) -ge 500 -a $retval -eq 0 ]; then
    echo "a user can log system."
else
    echo "a user cannot log."
fi
