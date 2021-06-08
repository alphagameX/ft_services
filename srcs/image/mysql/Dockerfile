FROM arthur/base

ENV SERVICE mysql

RUN apk add mariadb mariadb-common mariadb-client
COPY files/run.sh /tmp
COPY files/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY probe/live.sh /tmp/live.sh
RUN chmod +x /tmp/live.sh

COPY probe/ready.sh /tmp/ready.sh
RUN chmod +x /tmp/ready.sh



CMD [ "sh", "/tmp/run.sh" ]