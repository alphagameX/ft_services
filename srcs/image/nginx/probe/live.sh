#!/bin/sh

if ! pgrep -x "telegraf" > /dev/null
then
        exit 1
fi

if ! pgrep "nginx" > /dev/null
then
        exit 1
fi