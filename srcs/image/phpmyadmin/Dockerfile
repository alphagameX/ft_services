FROM arthur/base

ENV SERVICE phpmyadmin


RUN apk add nginx 
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/localhost.pem -keyout /etc/ssl/localhost.key -subj "/C=FR/ST=Paris/L=Paris/O=PhpMyAdmin K8s FT/OU=Arthur/CN=localhost"
RUN apk add php7 php7-fpm php7-opcache
RUN apk add php7-gd php7-mysqli php7-zlib php7-curl php7-phar php7-json php7-mbstring php7-ctype php7-simplexml php7-tokenizer php7-xmlwriter php-session php-bz2 php-zip

RUN wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz

RUN tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz
RUN rm phpMyAdmin-5.0.2-all-languages.tar.gz
RUN mv phpMyAdmin-5.0.2-all-languages /tmp/phpmyadmin
RUN chmod -R 777 /tmp/phpmyadmin


COPY default.conf /etc/nginx/conf.d/default.conf 
COPY run.sh .
COPY config.inc.php /tmp/phpmyadmin/config.inc.php
COPY live.sh /tmp/live.sh
RUN chmod +x /tmp/live.sh

CMD [ "sh", "run.sh"]