#!/bin/sh


if ! pgrep -x "telegraf" > /dev/null
then
    exit 1
fi

if ! pgrep "influx" > /dev/null
then
    exit 1
fi