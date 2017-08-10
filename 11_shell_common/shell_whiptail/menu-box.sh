#!/bin/bash

# Syntax
# whiptail --title "<menu title>" --menu "<text to show>" <height> <width> <menu height> [ <tag> <item> ] . . .

OPTIONS=$(whiptail --title "Package Selection" --menu "Choose your package" 15 60 4 \
"1" "Minimal install" \
"2" "Server install" \
"3" "Web-server install" \
"4" "Openstack install" \
"5" "custom install" 3>&1 1>&2 2>&3)

exitstatus=$?

if [ $exitstatus = 0 ]; then
	echo "Your selected option:" $OPTIONS
else
	echo "You chose cancel."
fi
