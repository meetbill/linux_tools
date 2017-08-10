#!/bin/sh


x=''
NUM=3
function ProcessBar()
{
	x=##########$x
	printf "test:[%-${NUM}0s]\r" $x
	sleep 0.1
}

ProcessBar
ProcessBar
ProcessBar
echo
