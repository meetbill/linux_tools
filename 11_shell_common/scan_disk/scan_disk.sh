#!/bin/bash
#########################################################################
# File Name: disk.sh
# Author: meetbill
# mail: meetbill@163.com
# Created Time: 2017-08-22 20:37:35
#########################################################################

disklist=$(ls /dev/[sh]d* | tr -d "[0-9]+$" | uniq)
for i in $disklist
do
    check=$(fdisk -l ${i}  | grep ${i} | wc -l)
    if [[ "w$check" == "w1"  ]]
    then
        echo ${i}
    fi
done

