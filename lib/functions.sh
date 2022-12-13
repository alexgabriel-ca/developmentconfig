#!/bin/bash
#Author: Alex Gabriel <alex@alexgabriel.ca>
#Created: 18/02/2019
#Modified: 08/10/2022
#Description: Functions used in devconfig.sh.
#License: GPL 3.0

function pause() {
	read -rp "$*"
}

function addDocker() {
	read -rp "Do you wish to install Docker? [yn] " adddocker
	if [ "$adddocker" == y ]; then
		#Enable key based authentication

		echo "	Installing Docker..."
		{
			#Download and install Docker CE
			apt-get update
			apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
			curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
			echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
			apt-get update
			apt-get install -y docker-ce docker-ce-cli containerd.io
			#Add user running the script to docker group
			usermod -aG docker $SUDO_USER
			#Download and install Docker machine
			curl -L https://github.com/docker/machine/releases/download/v0.12.2/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine
			chmod +x /tmp/docker-machine
			cp /tmp/docker-machine /usr/local/bin/docker-machine
			#Download and install Docker compose
			curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
		}
		echo "	Docker has been installed and configured."
		echo ""
	else
		echo "	Docker installation has been skipped."
	fi
}

function addTerraform() {
	read -rp "Do you wish to install Terraform? [yn] " adddocker
	if [ "$adddocker" == y ]; then
		#Enable key based authentication

		echo "	Installing Terraform..."
		{
			#Download and install Terraform
			apt-get update && sudo apt-get install -y gnupg software-properties-common
			wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
			gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
			echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
			apt update
			apt-get install terraform
		}
		echo "	Terraform has been installed and configured."
		echo ""
	else
		echo "	Terraform installation has been skipped."
	fi
}

function addSoftware() {
	read -rp "Do you wish to install basic software? [yn] " addsoftware
	if [ "$addsoftware" == y ]; then
		#Enable key based authentication

		echo "	Installing software..."
		{
			apt-get update
			apt-get install -y build-essential chrome-gnome-shell curl default-jdk default-jre dkms git gnome-tweaks keepassx libegl1-mesa libffi-dev libgl1-mesa-glx libxcb-xtest0 linux-headers-generic soundconverter ubuntu-restricted-extras vlc vorbisgain
			snap install clementine spotify
			snap install intellij-idea-ultimate --classic --edge
		}
		echo "	Software has been installed and configured."
		echo ""
	else
		echo "	Software installation has been skipped."
	fi
}

function addWebStuff() {
	read -rp "Do you wish to install Chrome, InSync and Zoom? [yn] " addwebstuff
	if [ "$addwebstuff" == y ]; then
		#Enable key based authentication

		echo "	Installing Chrome, InSync and Zoom..."
		{
			wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
			wget -c https://zoom.us/client/latest/zoom_amd64.deb
			wget -c https://cdn.insynchq.com/builds/linux/insync_3.7.12.50395-jammy_amd64.deb
			dpkg -i google-chrome-stable_current_amd64.deb
			dpkg -i zoom_amd64.deb
			dpkg -i insync_3.7.0.50216-impish_amd64.deb
		}
		echo "	Chrome, InSync and Zoom have been installed and configured."
		echo ""
	else
		echo "	Chrome, InSync and Zoom installation has been skipped."
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
	read -rp "Do you wish to install NetBeans? [yn] " installNetBeans
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
			apt-get install -y nodejs npm
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
			apt-get install -y apache2 libapache2-mod-php8.1 mysql-server php-cgi php-curl php-json php-mysql phpmyadmin php8.1-dev php8.1
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
	read -rp "Do you wish to enable PHP static analysis tools? [yn] " setupStatAnalysis
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
