#!/bin/bash
#Author: Alex Gabriel <alex@alexgabriel.ca>
#Created: 18/02/2019
#Modified: 18/02/2019
#Description: Functions used in devconfig.sh.
#License: GPL 3.0

function pause() {
	read -rp "$*"
}

function addSoftware() {
	read -rp "Do you wish to install basic software? [yn] " addsoftware
	if [ "$addsoftware" == y ]; then
		#Enable key based authentication

		echo "	Installing software..."
		{
			apt-get update
			apt-get install -y banshee build-essential chrome-gnome-shell curl default-jre default-jdk evolution fslint git gnome-tweak-tool keepassx libxcb-xtest0 sni-qt soundconverter ubuntu-restricted-extras vlc vorbisgain
			wget -c https://d2t3ff60b2tol4.cloudfront.net/builds/insync_1.5.5.37367-artful_amd64.deb
			wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
			wget -c https://d11yldzmag5yn.cloudfront.net/prod/2.7.162522.0121/zoom_amd64.deb
			dpkg -i insync_1.5.5.37367-artful_amd64.deb
			dpkg -i google-chrome-stable_current_amd64.deb
			dpkg -i zoom_amd64.deb
		}
		echo "	Software has been installed and configured."
		echo ""
	else
		echo "	Software installation has been skipped."
	fi
}

function removeJunk() {
	read -rp "Do you wish to remove Firefox, Totem, Thunderbird, and Rhythmbox? [yn] " removejunk
	if [ "$removejunk" == y ]; then
		echo "	Removing unused applications..."
		{
			apt-get --purge -y autoremove firefox rhythmbox totem thunderbird
			echo "	Firefox, Totem, and Rhythmbox have been removed."
			echo ""
		}
	else
		echo "	Firefox, Totem, and Rhythmbox removal has been skipped."
	fi
}

function addJDK() {
	read -rp "Do you wish to install Oracle JDK 8? [yn] " addJDK
	if [ "$addJDK" == y ]; then
		echo "	Adding Oracle JDK 8..."
		{
			add-apt-repository -y ppa:webupd8team/java
			apt-get update
			apt-get install -y oracle-java8-installer
		}
		echo "	Oracle JDK 8 has been installed."
		echo ""
	else
		echo "	Oracle JDK 8 install has been skipped."
	fi
}

function installNetBeans() {
	read -rp "Do you wish to install NetBeans 11? [yn] " installNetBeans
	if [ "$installNetBeans" == y ]; then
		echo "	Installing NetBeans..."
		{
			snap install netbeans --classic
		}

		echo "	NetBeans has been installed."
		echo ""
	else
		echo "	NetBeans install has been skipped."
	fi
}

function installNode() {
	read -rp "Do you wish to install Node.js? [yn] " installNode
	if [ "$installNode" == y ]; then
		echo "Installing node and some NPM modules..."
		{
			curl -sL https://deb.nodesource.com/setup_10.x | bash -E
			apt-get install -y nodejs
			npm install -g axios bower express express-generator grunt gulp karma less lodash mongoose node-inspect nodemon request sass yargs
		}
		echo "	Node.js has been installed and configured."
		echo ""
	else
		echo "	Node.js install has been skipped."
	fi
}

function setupLAMP() {
	read -rp "Do you wish to setup a LAMP server? [yn] " setupLAMP
	if [ "$setupLAMP" == y ]; then
		echo "Setting up LAMP with PHP MyAdmin..."
		{
			apt-get install -y apache2 libapache2-mod-php7.2 mysql-server php-cgi php-curl php-json php-mysql phpmyadmin php7.2-dev php7.2
			a2enmod userdir
			mysql_secure_installation
			systemctl restart apache2
		}
		echo "	LAMP with PHP MyAdmin has been installed and configured."
		echo ""
	else
		echo "	LAMP with PHP MyAdmin install has been skipped."
	fi
}

function setupStatAnalysis() {
	read -rp "Do you wish to enable PHP analysis tools? [yn] " setupStatAnalysis
	if [ "$setupStatAnalysis" == y ]; then
		echo "Setting up LAMP with PHP MyAdmin..."
		{
			wget https://cs.sensiolabs.org/download/php-cs-fixer-v2.phar -O php-cs-fixer
			chmod a+x php-cs-fixer
			mv php-cs-fixer /usr/local/bin/php-cs-fixer

			wget https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
			chmod a+x phpcs.phar
			mv phpcs.phar /usr/local/bin/phpcs

			wget https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
			chmod a+x phpcbf.phar
			mv phpcbf.phar /usr/local/bin/phpcbf

			wget -c http://static.phpmd.org/php/latest/phpmd.phar
			chmod a+x phpmd.phar
			mv phpmd.phar /usr/local/bin/phpmd
		}
		echo "	PHP static analysis tools have been installed and configured."
		echo ""
	else
		echo "	PHP static analysis tool installation has been skipped."
	fi
}

function systemUpgrade() {
	read -rp "Do you wish to perform a system update? [yn] " systemUpdate
	if [ "$systemUpdate" == y ]; then
		echo "Setting up LAMP with PHP MyAdmin..."
		{
			apt-get update
			apt-get upgrade -y
		}
		echo "	The latest updates have been installed and configured."
		echo ""
	else
		echo "	Installation of the latest updates has been skipped."
	fi
}
