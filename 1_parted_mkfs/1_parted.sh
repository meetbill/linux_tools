#!/bin/sh
PATH=/bin:/sbin:/usr/bin:/usr/sbin
i=1
while [ $i -lt 13 ]
do
	j=`echo $i|awk '{printf "%c",97+$i}'`
	echo $j
	parted /dev/sd$j << End
mklabel gpt
mkpart primary 0% 100%
quit
End
	let i+=1
done
