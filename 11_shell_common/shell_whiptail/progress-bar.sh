#!/bin/bash

# Syntax
# whiptail --gauge "<test to show>" <height> <width> <inital percent>

{
	for ((i=0; i<=100; i+=20)); do
		sleep 1
		echo $i
	done
} | whiptail --gauge "please wait while installing" 6 60 0

