#!/usr/bin/env bash
#---------------------------------------------------------------------
# install.sh
#
# ISPConfig 3 system installer
#
# Script: install.sh
# Version: 2.2.1
# Author: Matteo Temporini <temporini.matteo@gmail.com>
# Description: This script will install all the packages needed to install
# ISPConfig 3 on your server.
#
#
#---------------------------------------------------------------------

#Those lines are for logging porpuses
exec > >(tee -i /var/log/ispconfig_setup.log)
exec 2>&1

#---------------------------------------------------------------------
# Global variables
#---------------------------------------------------------------------
CFG_HOSTNAME_FQDN=`hostname -f`;
WT_BACKTITLE="ISPConfig 3 System Installer from Temporini Matteo"

# Bash Colour
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0m' # No Color


#Saving current directory
PWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#---------------------------------------------------------------------
# Load needed functions
#---------------------------------------------------------------------

DISTRO=centos7
CFG_HOSTNAME_FQDN=$ISP_HOSTNAME
CFG_ISP_PASSWORD=$ISP_ADMIN_PASS
CFG_MYSQL_ROOT_PWD=$MYSQL_ROOT_PASS
CFG_WEBSERVER=apache
SSL_COUNTRY=SK
SSL_STATE=BB
SSL_LOCALITY=BB
SSL_ORGANIZATION=fascinatin
SSL_ORGUNIT=IT

#---------------------------------------------------------------------
# Load needed Modules
#---------------------------------------------------------------------

source $PWD/distros/$DISTRO/install_mysql.sh
source $PWD/distros/$DISTRO/install_webserver.sh
source $PWD/distros/$DISTRO/install_ftp.sh
source $PWD/distros/$DISTRO/install_ispconfig.sh

#---------------------------------------------------------------------
# Main program [ main() ]
#    Run the installer
#---------------------------------------------------------------------
clear
echo "Welcome to ISPConfig Setup Script v.2.2.1"
echo "This software is developed by Temporini Matteo"
echo "with the support of the community."
echo "You can visit my website at the followings URLS"
echo "http://www.servisys.it http://www.temporini.net"
echo "and contact me with the following information"
echo "contact email/hangout: temporini.matteo@gmail.com"
echo "skype: matteo.temporini"
echo "========================================="
echo "ISPConfig 3 System installer"
echo "========================================="
echo
echo "This script will do a nearly unattended intallation of"
echo "all software needed to run ISPConfig 3."
echo "When this script starts running, it'll keep going all the way"
echo "So before you continue, please make sure the following checklist is ok:"
echo
echo "- This is a clean standard clean installation for supported systems";
echo "- Internet connection is working properly";
echo

CFG_MULTISERVER=no

if [ -f /etc/centos-release ]; then
	#InstallSQLServer 
	InstallWebServer
	InstallFTP 
	InstallISPConfig
	echo -e "${green}Well done ISPConfig installed and configured correctly :D ${NC}"
	echo "Now you can connect to your ISPConfig installation at https://$CFG_HOSTNAME_FQDN:8080 or https://$ETH0_IP:8080"
	echo "You can visit my GitHub profile at https://github.com/servisys/ispconfig_setup/"
	echo -e "${red}If you setup Roundcube webmail go to http://$CFG_HOSTNAME_FQDN/roundcubemail/installer and configure db connection${NC}"
	echo -e "${red}After that disable access to installer in /etc/httpd/conf.d/roundcubemail.conf${NC}"
else
	echo "${red}Unsupported linux distribution.${NC}"
fi

exit 0
