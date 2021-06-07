FROM arthur/base

ENV SERVICE grafana

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/localhost.pem -keyout /etc/ssl/localhost.key -subj "/C=FR/ST=Paris/L=Paris/O=Grafana K8s FT/OU=Arthur/CN=localhost"
RUN wget https://dl.grafana.com/oss/release/grafana-7.5.7.linux-amd64.tar.gz
RUN tar -zxvf grafana-7.5.7.linux-amd64.tar.gz

RUN apk add nginx
RUN mv grafana-7.5.7 grafana
RUN rm grafana-7.5.7.linux-amd64.tar.gz
RUN apk add libc6-compat
RUN apk update && apk add 

COPY default.conf etc/nginx/http.d/default.conf
COPY grafana.db grafana/data/grafana.db
COPY defaults.ini grafana/conf/defaults.ini
COPY run.sh /tmp/run.sh

COPY live.sh /tmp/live.sh
RUN chmod +x /tmp/live.sh

CMD ["sh", "tmp/run.sh"]