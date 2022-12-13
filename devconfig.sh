#!/bin/bash
#Author: Alex Gabriel <alex@alexgabriel.ca>
#Created: 17/01/2019
#Modified: 02/09/2021
#Description: Short configuration script intended to configure basic desktop/development environment.
#License: GPL 3.0

#TODO: Automatic install of ubuntu-restricted-extras
#TODO: Automatic install of oracle-java8-installer
#TODO: Automatic install of phpmyadmin

echo ""
echo "This is a setup script designed to install basic desktop and development settings.  More may be added at a later time."
echo ""

gpltext="gpl-3.0.txt"
more "$gpltext"
read -p "Do you agree to the terms and conditions and conditions as specified in the GNU Public License v3? [yn]" accept

if [ $accept == "y" ]; then
	{
		source "lib/functions.sh"
		addDocker
		addTerraform
		addSoftware
		addWebStuff
		removeJunk
		#addJDK
		#installNetBeans
		installNode
		setupLAMP
		setupStatAnalysis
		systemUpgrade
	}
else
	exit
fi
echo ""
echo "The setup script has finished and will now exit."
echo ""
