#!/bin/bash

# Syntax
# whiptail --title "<input box title>" --inputbox "<text to show>" <height> <width> <default-text> 


MACHINE=$(whiptail --title "Configure profile" --inputbox "What is your Computer Name?" 10 60 Ubuntu 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
	echo "Your Computer Name is:" $MACHINE
else
	echo "You chose Cancel."
fi
