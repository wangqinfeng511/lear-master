#!/bin/bash
#
target=/mnt/sysroot

cmndcopy() {
    if ! which $1 &> /dev/null; then
	return 1
    fi

    cmnd=$(which --skip-alias $1)
    cmndpath=$(dirname $cmnd)
    
    [ -d $target/$cmndpath ] || mkdir -p $target/$cmndpath
    [ -e $target/$cmnd ] || cp $cmnd $target/$cmnd
    return 0
}

libcopy() {
    libpath=$(dirname $1)
    
    [ -d $target/$libpath ] || mkdir -p $target/$libpath
    [ -e $target/$1 ] || cp $1 $target/$1
}

read -p "Plz enter a command: " binary

until [ "$binary" == "quit" ]; do
    cmndcopy $binary
    retval=$?


    if [ $retval -eq 0 ]; then
        binary=$(which --skip-alias $binary)
        for lib in $(ldd $binary | grep -o "/[^[:space:]]*lib[^[:space:]]*\.so[^[:space:]]*"); do
        	libcopy $lib
        done
    else
	read -p "$binary is not correct, plz enter again: " binary
        continue
    fi

    read -p "Plz enter a command(quit for quiting): " binary
done
