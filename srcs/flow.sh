service mysql start

chown -R www-data /var/www/*
chmod -R 755 /var/www/*

mkdir /var/www/flow

mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/flow.pem -keyout /etc/nginx/ssl/flow.key -subj "/C=IT/ST=Italy/L=Rome/O=42 School/OU=flow/CN=flow"

cp ./tmp/nginx-conf_on /etc/nginx/sites-available/flow
ln -s /etc/nginx/sites-available/flow /etc/nginx/sites-enabled/flow
rm -rf /etc/nginx/sites-enabled/default

echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

mkdir /var/www/flow/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/flow/phpmyadmin
mv ./tmp/phpmyadmin.inc.php /var/www/flow/phpmyadmin/config.inc.php

cd /tmp/
wget -c https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress/ /var/www/flow
mv /tmp/wp-config.php /var/www/flow/wordpress

service php7.3-fpm start
service nginx start
bash
