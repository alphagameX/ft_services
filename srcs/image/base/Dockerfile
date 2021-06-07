
FROM alpine

RUN apk update
RUN apk upgrade
RUN apk add openrc
RUN openrc
RUN touch /run/openrc/softlevel
RUN rc-update

RUN apk add openssl
RUN apk add telegraf
RUN mkdir /var/log/telegraf
COPY telegraf.conf /etc/telegraf/telegraf.conf

