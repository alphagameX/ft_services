#!/bin/sh

if ! pgrep "vsftpd" > /dev/null
then 
    exit 1
fi

if ! pgrep -x "telegraf" > /dev/null
then 
    exit 1
fi

