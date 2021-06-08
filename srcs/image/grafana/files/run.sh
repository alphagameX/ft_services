mkdir /var/log/grafana
service nginx start

cd ./grafana/bin/ && ./grafana-server > /var/log/grafana/access.log &
sed -i -e "s/SERVICE/$SERVICE/g" /etc/telegraf/telegraf.conf
telegraf > /var/log/telegraf/monitor.log &

tail -f /var/log/*/*.log