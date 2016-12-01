#!/bin/bash
#check raid disk status

MEGACLI="sudo /opt/MegaRAID/MegaCli/MegaCli64 "

$MEGACLI -pdlist -aALL -NoLog | grep "Firmware state" | awk -F : '{print $2}' | awk -F , '{print $1}' >/tmp/fireware.log
$MEGACLI -pdlist -aALL -NoLog | grep -E "Media Error|Other Error" | awk -F : '{print $2}' >/tmp/disk.log

for i in `cat < /tmp/disk.log`
do
	if [ $i -ne 0 ];then
		echo "raid_disk_error"
	fi
done

for i in `cat < /tmp/fireware.log`
do
	if [ $i !=  Online ];then
		echo "raid_disk_offline"
	fi
done
