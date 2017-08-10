#!/bin/bash

# Syntax
# whiptail --title "<dialog box title>" --yesno "<text to show>" <height> <width> 


if (whiptail --title "Select Option" --yesno "Choose Between Yes and No." 10 60) then
	echo "You chose Yes. Exit status was $?."
else
	echo "You chose No. Exit status was $?."
fi
