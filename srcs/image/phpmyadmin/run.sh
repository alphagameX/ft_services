#!/bin/sh

sed -i -e 's/node_ip/'$NODE_IP'/g' /tmp/phpmyadmin/config.inc.php

service php-fpm7 start
service nginx start


sed -i -e "s/SERVICE/$SERVICE/g" /etc/telegraf/telegraf.conf
telegraf > /var/log/telegraf/monitor.log &
tail -f /var/log/*/*.log
