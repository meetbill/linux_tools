#!/bin/sh
PATH=/bin:/sbin:/usr/bin:/usr/sbin
i=1
while [ $i -lt 13 ]
do
	j=`echo $i|awk '{printf "%c",97+$i}'`
	echo $j
	mkdir -p /mnt/sd$j
	let i+=1
done
