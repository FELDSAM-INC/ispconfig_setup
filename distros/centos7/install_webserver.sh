#---------------------------------------------------------------------
# Function: InstallWebServer
#    Install and configure Apache2, php + modules
#---------------------------------------------------------------------
InstallWebServer() {

  if [ $CFG_WEBSERVER == "apache" ]; then
    echo "Installing Apache and..."
    yum -y install httpd
	echo -e "${green}done!${NC}\n"
	echo "Installing PHP and Modules... "
	yum -y install mod_ssl php php-mysql php-mbstring php-devel php-gd php-imap php-ldap php-mysql php-odbc php-pear php-xml php-xmlrpc php-pecl-apc php-mbstring php-mcrypt php-mssql php-snmp php-soap php-tidy php-fpm httpd-devel > /dev/null 2>&1 
	echo "Installing needed Programs for PHP and Apache... "
	yum -y install curl curl-devel perl-libwww-perl ImageMagick libxml2 libxml2-devel mod_fcgid php-cli > /dev/null 2>&1
	echo -e "${green}done!${NC}\n"	
	
	sed -i '0,/<FilesMatch \\.php$>/ s/<FilesMatch \\.php$>/<Directory \/usr\/share>\n<FilesMatch \\.php$>/' /etc/httpd/conf.d/php.conf
	sed -i '0,/<\/FilesMatch>/ s/<\/FilesMatch>/<\/FilesMatch>\n<\/Directory>/' /etc/httpd/conf.d/php.conf
	
	systemctl start php-fpm.service
    systemctl enable php-fpm.service
    systemctl enable httpd.service
	systemctl restart  httpd.service
	echo -e "${green}done! ${NC}\n"
  else
    echo "Sorry Nginx not implemented Yet"
	read DUMMY
  fi
  echo -e "${green}done! ${NC}\n"
}
