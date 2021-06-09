#!/bin/bash

# setup apache
yum install -y httpd
systemctl enable httpd.service

# setup mysql
yum install -y mysql
function m() {
    mysql -h${db_host} -u${db_root_user} -p${db_root_password} $@
}
m -e "CREATE DATABASE IF NOT EXISTS ${wp_db_name} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
m -e "CREATE USER IF NOT EXISTS '${wp_db_user}'@'%' IDENTIFIED BY '${wp_db_password}';"
m -e "GRANT ALL ON ${wp_db_name}.* TO '${wp_db_user}'@'%';"
m -e "FLUSH PRIVILEGES;"

# setup wordpress
amazon-linux-extras install -y php7.2
yum install -y php php-mbstrings php-xml php-gd php-devel.x86_64
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --locale=ja --path=/var/www/html
cd /var/www/html
wp core config \
    --dbname=${wp_db_name} \
    --dbuser=${wp_db_user} \
    --dbpass=${wp_db_password} \
    --dbhost=${db_host}

wp core install \
    --url=${wp_url} \
    --title=${wp_title} \
    --admin_user=${wp_admin_user} \
    --admin_password=${wp_admin_password} \
    --admin_email=${wp_admin_email}
sudo /usr/local/bin/wp  plugin install amazon-s3-and-cloudfront
wp plugin activate amazon-s3-and-cloudfront

# information to distinguish insntanece from client
echo $HOSTNAME > /var/www/html/test.html

# start apache
chown apache:apache /var/www/html/ -R
systemctl start httpd.service
