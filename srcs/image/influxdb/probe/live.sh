#!/bin/sh


if ! pgrep telegraf > /dev/null
then 
    exit 1
fi

if ! pgrep influx > /dev/null
then
    exit 1
fi