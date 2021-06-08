




while [ $( kubectl get pods -l app=influxdb -o json | jq '.items[0].status.conditions[1].status') = "\"True\"" ] 
do
    # echo $( kubectl get pods -l app=influxdb -o json | jq '.items[0].status.conditions[1].status')
    printf "Waiting for pods is ready\r"
    sleep 1
done