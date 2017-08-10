#!/bin/bash

# syntax
# whiptail --title "<password box title>" --passwordbox "<text to show>" <height> <width>

PASSWD=$(whiptail --title "Configure Password" --passwordbox "Enter your password here and choose OK to continue." 10 60 3>&1 1>&2 2>&3)

exitstatus=$?

if [ $exitstatus=0 ]; then
	echo "Your password is:" $PASSWD
else
	echo "You chose Cancel."
fi
