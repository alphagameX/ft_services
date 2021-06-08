#!/bin/sh

if echo "show databases" | influx 2> /dev/null > /dev/null 
then
    exit 0
else
    exit 1
fi