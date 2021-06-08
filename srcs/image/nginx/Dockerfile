FROM arthur/base

ENV SERVICE nginx

RUN apk add nginx 
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/localhost.pem -keyout /etc/ssl/localhost.key -subj "/C=FR/ST=Paris/L=Paris/O=Nginx K8s FT/OU=Arthur/CN=localhost"

COPY files/run.sh run.sh
COPY files/default.conf /etc/nginx/http.d/default.conf
COPY files/index.html /tmp/index.html
COPY probe/live.sh /tmp/live.sh
RUN chmod +x /tmp/live.sh

CMD ["sh", "run.sh"]