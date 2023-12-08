#!/bin/bash

endtime=$(date -u -v+1d +%s)

while [[ $(date -u +%s) -le $endtime ]]
do
    time=`date +%H:%M:%S`
    echo "Time Now: $time"
    data=`printf '{ 
            "commands": [{
                "method": "upsert",
                "collection": "heartbeat",
                "id": "heartbeat",
                "value": {
                    "time": "%s"
                }
            }]
        }' $time`

    echo $data
    curl --location --request POST '{APP_ID}.cloud.ditto.live/api/v4/store/write' \
        --header 'Authorization: Bearer {YOUR_API_KEY}' \
        --header 'Content-Type: application/json' \
        --data-raw "$data"
    sleep 10
done
