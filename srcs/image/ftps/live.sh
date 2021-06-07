#!/bin/sh

if ! pgrep vsftpd > /dev/null
then 
    exit 1
fi

if ! pgrep telegraf > /dev/null
then 
    exit 1
fi

