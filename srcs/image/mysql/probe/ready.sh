#!/bin/sh

if echo "SHOW DATABASES" | mysql -uroot > /dev/null 2> /dev/null
then 
    exit 0
else
    exit 1
fi
