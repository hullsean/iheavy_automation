#!/bin/sh

# still working on the final list here
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
# need to fetch this secret from s3 or server variable
#echo "password=xxxxx" >> /root/.my.cnf


# install composer for php dependencies
export COMPOSE_HOME=/root

echo "installing composer..."
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer

# test composer install
if ! [ -x "$(command -v composer)" ]; then
  echo 'Error: composer is not installed.' >&2
  exit 1
fi


# fetch config files from private S3 folder
# need to fetch from git
aws s3 cp s3://bucket-config/iheavy_files.zip .

# unzip files
unzip iheavy_files.zip 

# use composer to get wordpress & plugins
composer update

# check for existing wordpress & wp-content folders??

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

