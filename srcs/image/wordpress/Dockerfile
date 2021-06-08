FROM arthur/base

ENV SERVICE wordpress

RUN apk add nginx
RUN apk add php7 php7-fpm php7-opcache
RUN apk add php7-mysqli         
RUN apk add php7-gd
RUN apk add php7-zlib
RUN apk add php7-curl
RUN apk add php7-phar
RUN apk add php7-json
RUN apk add php7-mbstring
RUN apk add php7-ctype
RUN apk add php7-simplexml
RUN apk add php7-tokenizer
RUN apk add php7-xmlwriter

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/localhost.pem -keyout /etc/ssl/localhost.key -subj "/C=FR/ST=Paris/L=Paris/O=Wordpress K8s FT/OU=Arthur/CN=localhost"
RUN apk add mysql-client

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar wp-cli.phar
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
RUN wp core download --locale=fr_FR --path="/var/wordpress/"


COPY files/run.sh /tmp
COPY files/default.conf etc/nginx/http.d/default.conf
COPY probe/live.sh /tmp/live.sh
RUN chmod +x /tmp/live.sh

CMD [ "sh", "/tmp/run.sh" ]