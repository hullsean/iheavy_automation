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

# install composer for php dependencies
export COMPOSER_HOME=/root

cd /root

echo "installing composer..."
wget https://getcomposer.org/installer
mv installer composer-setup.php
php composer-setup.php
mv composer.phar /usr/bin/composer

# test composer install
if ! [ -x "$(command -v composer)" ]; then
  echo 'Error: composer is not installed.' >&2
  exit 1
fi


# fetch config files from private S3 folder
# need to fetch from git
#aws s3 cp s3://iheavy-config/iheavy_files.zip .
export HOME=/root
git config --global credential.UseHttpPath true
git config --global credential.helper '!aws codecommit credential-helper $@'
git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/iheavy
cd iheavy

# unzip files
#unzip iheavy_files.zip 

# use composer to get wordpress & plugins
/usr/bin/composer update

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

# mount EFS for external /homedirs!
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 172.30.4.158:/ efs

