#!/bin/bash

for i in {0..9}; do
    useradd stud10$i
    echo stud10$i | passwd --stdin stud10$i
done
