#!/bin/bash

build_image()
{
  docker build -t arthur/$1 srcs/image/$1 || build_image $1
}

delete_deployment() {
    if [ -n "$1" ]; then
        docker image rm arthur/base 
        docker image rm $1
        kubectl delete -f srcs/deploy/$1.yaml
        kubectl delete pod -l app=$1
    fi
}
create_deployement() { 
    if [ -n "$1" ]; then
        build_image base
        build_image $1
        kubectl create -f srcs/deploy/$1.yaml
        while [ $( kubectl get pods -l app=influxdb -o json | jq '.items[0].status.conditions[1].status') = "\"False\"" ] 
        do
            echo -n -e "Waiting for pods is ready\r"
            sleep 1
        done
    fi
}
reload_deployement() {
    if [ -n "$1" ]; then
        delete_deployment $1
        create_deployement $1
    fi
}

eval $(minikube docker-env)

reload_deployement $1

eval $(minikube docker-env -u)
