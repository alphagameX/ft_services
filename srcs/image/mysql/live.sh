#!/bin/sh

if ! pgrep telegraf > /dev/null
then 
    exit 1
fi

if ! pgrep mariadb > /dev/null
then
    exit 1
fi