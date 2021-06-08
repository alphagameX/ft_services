#!/bin/sh




while [ $( kubectl get pods -l app=mysql -o json | jq '.items[0].status.conditions[1].status') = "\"True\"" ] 
do
    printf "${YELLOW}Waiting for pods is ready\r"
    sleep 1
done