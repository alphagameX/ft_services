#!/bin/sh

if  nc -zv localhost:21
then
    exit 0
else
    exit 1
fi