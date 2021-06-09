
adduser -S $FTP_USER -s /bin/ash
addgroup $FTP_USER
addgroup $FTP_USER $FTP_USER

echo $FTP_USER:$FTP_PASSWORD | chpasswd

sed -i -e "s/NODE_IP/$NODE_IP/g" etc/vsftpd/vsftpd.conf

echo "salut mec!" | tee /var/volume/helloWorld

rc-update add vsftpd default
rc-service vsftpd start

touch /var/log/vsftpd/vsftpd.xfer.log
touch /var/log/vsftpd/vsftpd.log

sed -i -e "s/SERVICE/$SERVICE/g" /etc/telegraf/telegraf.conf
telegraf > /var/log/telegraf/monitor.log &
tail -f /var/log/*/*.log