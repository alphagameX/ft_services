#!/bin/sh

service nginx start

sed -i -e "s/SERVICE/$SERVICE/g" /etc/telegraf/telegraf.conf
telegraf > /var/log/telegraf/monitor.log &
tail -f /var/log/*/*.log