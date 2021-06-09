#!/bin/sh

service nginx start

sed -i -e "s/USERNAME_PHPMYADMIN/$DB_USER/g" tmp/index.html
sed -i -e "s/PASSWORD_PHPMYADMIN/$DB_PASSWORD/g" tmp/index.html

sed -i -e "s/USERNAME_WORDPRESS/$WORDPRESS_ADMIN/g" tmp/index.html
sed -i -e "s/PASSWORD_WORDPRESS/$WORDPRESS_ADMIN_PASSWORD/g" tmp/index.html

sed -i -e "s/USERNAME_FTPS/$FTP_USER/g" tmp/index.html
sed -i -e "s/PASSWORD_FTPS/$FTP_PASSWORD/g" tmp/index.html


sed -i -e "s/USERNAME_MYSQL/$DB_USER/g" tmp/index.html
sed -i -e "s/PASSWORD_MYSQL/$DB_PASSWORD/g" tmp/index.html


sed -i -e "s/SERVICE/$SERVICE/g" /etc/telegraf/telegraf.conf
telegraf > /var/log/telegraf/monitor.log &
tail -f /var/log/*/*.log