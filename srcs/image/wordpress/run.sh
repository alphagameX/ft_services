#!/bin/sh

until  echo "SHOW DATABASES;" | mysql -u$DB_USER -p$DB_PASSWORD -h "mysql" 

do
    echo "mysql waiting...."
done

wp config create --path="/var/wordpress" --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --dbhost="mysql"

wp core install \
     --path="/var/wordpress" \
     --url=https://$NODE_IP:5050 \
     --title=wordpress \
     --admin_user="$WORDPRESS_ADMIN" \
     --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
     --admin_email="$WORDPRESS_ADMIN_EMAIL" \
     --skip-email

i=1;
for role in 'editor' 'author' 'contributor' 'subscriber'
do
    wp user create user$i user$i@gmail.com \
        --role="$role" \
        --user_pass="user${i}password" \
        --display_name="user$i" \
        --path="/var/wordpress"
    i=$((i + 1));
done

wp config --path="/var/wordpress" set FS_METHOD direct
wp plugin --path="/var/wordpress" install media-from-ftp --activate

chmod 777 -R /var/wordpress

service php-fpm7 start
service nginx start

sed -i -e "s/SERVICE/$SERVICE/g" /etc/telegraf/telegraf.conf
telegraf > /var/log/telegraf/monitor.log &
tail -f /var/log/*/*.log


