#!/bin/bash

RESTORE='\033[0m'
GREEN='\033[00;32m'
BLUE='\033[00;34m'
YELLOW="\033[33;5m"

build_image()
{
  docker build -t arthur/$1 srcs/image/$1 || build_image $1
}

create_deployement() { 
    now=$(date +%s)
    if [ -n "$1" ]; then
        printf "${BLUE}building $1 image ${RESTORE}...\n"
        build_image $1
        printf "${BLUE}create deployment for $1 yaml${RESTORE}...\n"
        kubectl create -f srcs/deploy/$1.yaml 
        while [ $( kubectl get pods -l app=$1 -o json | jq '.items[0].status.conditions[1].status') = "\"False\"" ] 
        do
            printf "${YELLOW}Waiting for pods is ready${RESTORE}\r"
            sleep 1
        done
        clear
        printf "✓ ${GREEN}$1 is ready !${RESTORE}\n"
        res=$(date +%s)
        return $((res - now))
    fi
}

clear
printf "${BLUE}minikube starting...${RESTORE}\n"
now=$(date +%s)
minikube delete > /dev/null

if [ $(uname) = 'Darwin' ]; then
    minikube start --driver=hyperkit 
else
    minikube start 
fi
res=$(date +%s)
d1=$((res - now))

clear
printf "✓ ${GREEN}Minikube is ready !${RESTORE}\n"

eval $(minikube docker-env)

printf "${BLUE}Creating configmaps...${RESTORE}\n"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml 
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" 
NODE_ID=$(kubectl get nodes -o custom-columns="DATA:status.addresses[0].address" | sed -n 2p)
sed -e "s/NODE-SOURCE/$NODE_ID/g" srcs/deploy/metallb.yaml | kubectl create -f -
kubectl apply -f srcs/deploy/env.yaml 
clear
printf "${GREEN}Configmap is deployed...${RESTORE}\n" 


printf "${BLUE}Creating volumes...${RESTORE}\n"
kubectl apply -f srcs/deploy/volumes.yaml
clear
printf "✓ ${GREEN}Volumes is ready !${RESTORE}\n"

printf "${BLUE}Creating base image...${RESTORE}\n"
build_image base
clear
printf "✓ ${GREEN}Base image is ready !${RESTORE}\n"

create_deployement mysql
d2=$?

create_deployement influxdb
d3=$?

create_deployement phpmyadmin
d4=$?

create_deployement wordpress
d5=$?

create_deployement ftps
d6=$?

create_deployement nginx
d7=$?

create_deployement grafana
d8=$?

eval $(minikube docker-env -u)


sleep 1
clear

printf "✓ ${GREEN} FT_SERVICE IS UP ! ${RESTORE}\n\n" 

printf "${BLUE}minikube   ${RESTORE}| start in ${GREEN}${d1}s\n"
printf "${BLUE}mysql      ${RESTORE}| start in ${GREEN}${d2}s\n"
printf "${BLUE}influxdb   ${RESTORE}| start in ${GREEN}${d3}s\n"
printf "${BLUE}phpmyadmin ${RESTORE}| start in ${GREEN}${d4}s\n"
printf "${BLUE}wordpress  ${RESTORE}| start in ${GREEN}${d5}s\n"
printf "${BLUE}ftps       ${RESTORE}| start in ${GREEN}${d6}s\n"
printf "${BLUE}nginx      ${RESTORE}| start in ${GREEN}${d7}s\n"
printf "${BLUE}grafana    ${RESTORE}| start in ${GREEN}${d8}s\n\n\n"

echo "Opening dashboard !..."
minikube dashboard 2> /dev/null > /dev/null & 