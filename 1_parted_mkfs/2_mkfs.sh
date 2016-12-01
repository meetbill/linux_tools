#!/bin/sh
PATH=/bin:/sbin:/usr/bin:/usr/sbin
i=1
while [ $i -lt 13 ]
do
	j=`echo $i|awk '{printf "%c",97+$i}'`
	echo $j
	mkfs.ext4 /dev/sd${j}1 &
	let i+=1
done
