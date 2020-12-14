ip="$(hostname -I|cut -f1 -d ' ')"
read -sp "Enter the password you wish to have as MySQL root user: `echo $'\n> '`" DATABASE_PASS
read -p "Number of installations to create: `echo $'\n> '`" NUMBER_OF_INSTALLS
apt-get update
apt-get --assume-yes upgrade
apt-get -y install wget
apt-get -y install apache2
apt-get -y install mariadb-server
apt-get -y install htop
apt-get -y install git
mysqladmin -u root password "$DATABASE_PASS"
mysql -u root -p"$DATABASE_PASS" -e "UPDATE mysql.user SET Password=PASSWORD('$DATABASE_PASS') WHERE User='root'"
mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User=''"
mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'"
mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"
mysql -u root -p"$DATABASE_PASS" -e "CREATE USER 'ojs'@'localhost' IDENTIFIED BY 'ojsPass1234';"
mysql -u root -p"$DATABASE_PASS" -e "GRANT ALL PRIVILEGES ON *.* TO 'ojs'@'localhost' WITH GRANT OPTION;"
mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES;"
apt-get -y install build-essential
apt-get -y install php
apt-get -y install php-cli php-mbstring unzip php-zip php-xml php-dev php-mysql 
service apache2 restart
apt-get -y install curl
cd
wget http://pkp.sfu.ca/ojs/download/ojs-3.2.1-2.tar.gz
counter=1
while [ $counter -le $NUMBER_OF_INSTALLS ]
do
jourName="journal$counter"
cd /var/www/html/
mkdir $jourName
cd $jourName
tar --strip-components=1 -xvzf /root/ojs-3.2.1-2.tar.gz ojs-3.2.1-2/ -C .
cd /var/www/
mkdir "files_$jourName"
cd html/$jourName
cp config.TEMPLATE.inc.php config.inc.php
sed -i "s#base_url = \"http://pkp.sfu.ca/ojs\"#base_url = \"$ip/$jourName\"#g" config.inc.php
sed -i "s#password = ojs#password = ojsPass1234#g" config.inc.php
sed -i "s#name = ojs#name = $jourName#g" config.inc.php
sed -i "s#files_dir = files#files_dir = /var/www/files_$jourName#g" config.inc.php
sed -i "s#salt = \"YouMustSetASecretKeyHere!!\"#salt = \"ojsPass1234\"#g" config.inc.php
mysql -u root -p"$DATABASE_PASS" -e "CREATE DATABASE ${jourName};"
php tools/install.php << EOF
en_US
en_US
utf-8
utf8
/var/www/files_$jourName
$jourName
ojsPass1234
ojsPass1234
${jourName}@localhost.com
mysqli
localhost
ojs
ojsPass1234
$jourName
n
${jourName}@localhost
n
y
EOF
((counter++))
done
cd /var
chown -R www-data:www-data www/
