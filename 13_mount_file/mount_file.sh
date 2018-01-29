#!/bin/bash
#########################################################################
# File Name: mount_file.sh
# Author: meetbill
# mail: meetbill@163.com
# Created Time: 2018-01-29 20:02:23
#########################################################################

host=$(hostname)
disk1=${host}sn1_test
disk2=${host}sn2_test
disk3=${host}sn3_test

DISK_LIST="$disk1 $disk2 $disk3"

function mount_all() {
    for disk in $DISK_LIST;do
        sudo mkdir -p /vols/${disk}
        truncate -s 1000M /dev/${disk}
        mkfs.xfs -f  /dev/${disk}
        sudo mount -o loop /dev/${disk} /vols/${disk}
        sudo mkdir -p /vols/${disk}/${disk}/spare
    done
}

function umount_all() {
    for disk in $DISK_LIST;do
        umount /vols/${disk}
        rm /vols/${disk} -rf
        rm /vols/bad_disks.json -rf
    done
}

function usage() {
    echo "$0 mount_all"    
    echo "$0 umount_all"
    exit -1
}

case $1 in
    "mount_all")
        mount_all;;
    "umount_all")
        umount_all;;
    *)
        usage;;
esac
