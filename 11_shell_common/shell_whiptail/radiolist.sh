#!/bin/bash

# Syntax
# whiptail --title "<radiolist title>" --radiolist "<text to show>" <height> <width> <list height> [ <tag> <item> <status> ] . . .

VERSION=$(whiptail --title "Linux Distro version" --radiolist \
"What distro are you running?" 15 60 4 \
"Mint" "Basic usage" ON \
"Ubuntu" "Desktop usage" OFF \
"Debian" "Desktop & Server" OFF \
"CentOS" "Server usage" OFF 3>&1 1>&2 2>&3)

exitstatus=$?

if [ $exitstatus = 0 ]; then
	echo "The chosen distro is:" $VERSION
else
	echo "You chose Cancel."
fi
