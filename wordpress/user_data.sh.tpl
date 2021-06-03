#!/bin/bash

# setup apache
yum install -y httpd
systemctl enable httpd.service

# setup mysql
yum install -y mysql
mysql -h ${db_host} -u ${db_root_user} -p ${db_root_password} < ~/init.sql

# setup wordpress
amazon-linux-extras install -y php7.2
yum install -y php php-mbstrings
wget https://ja.wordpress.org/latest-ja.tar.gz
tar xzvf latest-ja.tar.gz
cp -r wordpress/* /var/www/html/
chown apache:apache /var/www/html/ -R

# start apache
systemctl start httpd.service
