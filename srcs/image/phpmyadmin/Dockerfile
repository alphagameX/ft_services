FROM arthur/base

ENV SERVICE phpmyadmin


RUN apk add nginx 
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/localhost.pem -keyout /etc/ssl/localhost.key -subj "/C=FR/ST=Paris/L=Paris/O=PhpMyAdmin K8s FT/OU=Arthur/CN=localhost"
RUN apk add php7 php7-fpm php7-opcache
RUN apk add php7-gd php7-mysqli php7-zlib php7-curl php7-phar php7-json php7-mbstring php7-ctype php7-simplexml php7-tokenizer php7-xmlwriter php-session php-bz2 php-zip php-iconv php-xml

ADD https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz phpmyadmin.tar.gz

RUN tar zxvf phpmyadmin.tar.gz
RUN rm phpmyadmin.tar.gz
RUN mv phpMyAdmin-5.1.1-all-languages /tmp/phpmyadmin
RUN chmod -R 777 /tmp/phpmyadmin


COPY files/default.conf /etc/nginx/conf.d/default.conf 
COPY files/run.sh run.sh
COPY files/config.inc.php /tmp/phpmyadmin/config.inc.php
COPY files/live.sh /tmp/live.sh
RUN chmod +x /tmp/live.sh

CMD [ "sh", "run.sh"]