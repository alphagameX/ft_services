#!/bin/sh

if ! pgrep "nginx" > /dev/null
then
    exit 1
fi

if ! pgrep "grafana-server" > /dev/null
then 
    exit 1
fi

if ! pgrep -x "telegraf" > /dev/null
then 
    exit 1
fi

