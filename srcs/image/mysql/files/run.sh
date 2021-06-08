#!/bin/sh

# INIT MARIA DB
/etc/init.d/mariadb setup 2> /dev/null

sleep 10

service mariadb start 2> /dev/null

until echo "SHOW DATABASES" | mysql -uroot > /dev/null
do
    echo "waiting..."
    sleep 1
done

echo "CREATE USER '$DB_USER'@'%' IDENTIFIED BY \"$DB_PASSWORD\";" | mysql -uroot
echo "CREATE DATABASE $DB_NAME;" | mysql -uroot
echo "GRANT ALL ON wordpress.* TO '$DB_USER'@'%';" | mysql -uroot
echo "FLUSH PRIVILEGES;" | mysql -uroot


sed -i -e "s/SERVICE/$SERVICE/g" /etc/telegraf/telegraf.conf


telegraf --debug

