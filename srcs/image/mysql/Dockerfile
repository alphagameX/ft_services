FROM arthur/base

ENV SERVICE mysql

RUN apk add mariadb mariadb-common mariadb-client

COPY run.sh /tmp
COPY mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY live.sh /tmp/live.sh
RUN chmod +x /tmp/live.sh


CMD [ "sh", "/tmp/run.sh" ]