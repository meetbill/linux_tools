#!/bin/bash 

# Syntax
# whiptail --title "<dialog box title>" --yesno "<text to show>" <height> <width>

# Customize Yes and No buttons
# customize the text for Yes and No buttons with "--yes-button" and "--no-button" options


if (whiptail --title "Select Distro  Option" --yes-button "Debian" --no-button "Arch-Linux" --yesno "Which do yo like better?" 10 60) then
	echo "You chose Debian Exit status was $?."
else
	echo "You chose Arch-Linux. Exit status was $?."
fi
