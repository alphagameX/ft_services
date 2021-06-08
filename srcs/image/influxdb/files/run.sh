#!/bin/sh

service influxdb start

until echo "show databases" | influx 2> /dev/null > /dev/null 
do
echo "waiting..."
done

echo "create user influxdb with password 'password'" | influx


sed -i -e "s/influxdb:8086/localhost:8086/g" /etc/telegraf/telegraf.conf
sed -i -e "s/SERVICE/$SERVICE/g" /etc/telegraf/telegraf.conf

telegraf > /var/log/telegraf/monitor.log &

tail -f /var/log/*/*.log