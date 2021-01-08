#!/bin/bash
#
if [[ "$1" =~ ^QUIT|Quit|quit$ ]]; then
    echo "Finished."
    exit 0
elif [ "$1" == 'yes' ]; then
    echo "Continue."
else
    echo "Unknown Argument."
    exit 1
fi
