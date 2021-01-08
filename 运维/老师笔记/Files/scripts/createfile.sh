#!/bin/bash
#
dirpath=/tmp/testdir-$(date +%F-%H-%M-%S)
mkdir $dirpath

for i in {1..100}; do
    touch $dirpath/file$i
    echo -e "Create \033[31mfile$i\033[0m finished."
done
