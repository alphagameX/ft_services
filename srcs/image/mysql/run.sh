#!/bin/sh

# INIT MARIA DB
/etc/init.d/mariadb setup

service mariadb start

mysql -uroot <<-EOF
    DROP DATABASE test;
    CREATE USER '$DB_USER'@'%' IDENTIFIED BY "$DB_PASSWORD";
    CREATE DATABASE $DB_NAME;
    GRANT ALL ON wordpress.* TO '$DB_USER'@'%';
    FLUSH PRIVILEGES;
EOF


sed -i -e "s/SERVICE/$SERVICE/g" /etc/telegraf/telegraf.conf
telegraf > /var/log/telegraf/monitor.log &
tail -f /var/log/*/*.log