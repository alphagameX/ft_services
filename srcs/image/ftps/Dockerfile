FROM arthur/base

EXPOSE 21 20
ENV SERVICE ftps

RUN apk add vsftpd
RUN mkdir var/log/vsftpd

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/localhost.pem -keyout /etc/ssl/localhost.key -subj "/C=FR/ST=Paris/L=Paris/O=Ftps K8s FT/OU=Arthur/CN=localhost"

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY run.sh /tmp

COPY live.sh /tmp/live.sh
RUN chmod +x /tmp/live.sh

CMD ["sh", "/tmp/run.sh"]