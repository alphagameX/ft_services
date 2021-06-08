
FROM alpine

RUN apk update
RUN apk upgrade
RUN apk add openrc
RUN openrc 2> /dev/null > /dev/null
RUN touch /run/openrc/softlevel
RUN rc-update 2> /dev/null > /dev/null

RUN apk add openssl
RUN apk add telegraf
RUN mkdir /var/log/telegraf
COPY telegraf.conf /etc/telegraf/telegraf.conf

