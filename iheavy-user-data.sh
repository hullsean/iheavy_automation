#!/bin/sh

yum update -y
yum install emacs -y
yum install mysql -y
yum install php -y
yum install git -y
yum install aws-cli -y
yum install gd -y
yum install php-gd -y
yum install ImageMagick -y
yum install php-mysql -y


yum install -y httpd24 
service httpd start
chkconfig httpd on

# setup mysql login
echo "[client]" >> /root/.my.cnf
echo "host=aaa-rds.cccwwkkjjjff.us-east-1.rds.amazonaws.com" >> /root/.my.cnf
echo "user=root" >> /root/.my.cnf
echo "password=abc123" >> /root/.my.cnf


# install composer for php dependencies
export COMPOSE_HOME=/root

echo "installing composer..."
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
# remove corrupt file check
#php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer


# fetch config files from private S3 folder
aws s3 cp s3://bucket-config/iheavy_files.zip .

# unzip files
unzip iheavy_files.zip 

# use composer to get wordpress & plugins
composer update

# move wordpress software
mv wordpress/* /var/www/html/

# move plugins
mv wp-content/plugins/* /var/www/html/wp-content/plugins/

# move pingdom test
mv a_simple_pingdom_test.php /var/www/html

# move htaccess
mv htaccess /var/www/html/.htaccess

# move httpd.conf
mv iheavy_httpd.conf /etc/httpd/conf.d

# move our wp-config into place
mv wp-config.php /var/www/html

# restart apache
service httpd restart

# allow apache to create uploads & any files inside wp-content
chown -R apache /var/www/html/wp-content

