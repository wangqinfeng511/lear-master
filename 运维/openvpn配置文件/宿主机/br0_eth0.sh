#!/bin/bash
brctl addif br0 em1
brctl addif br1 em2
service network restart
