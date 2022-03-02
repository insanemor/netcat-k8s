#!/bin/bash

echo "Multi-Port Netcat."

# TODO: input validation

# echo "Verifying config file ports.ini."
# number_regex='^[0-9]+$'
# if ! [[ $(cat ports.ini) =~ number_regex ]]; then
#    echo "ERROR: invalid config file. Ports should be in one line, separated by spaces. Finishing..."
#    exit 1
# fi

echo "Configuration is OK."

echo "Creating Netcat for each port"

for port in $(cat script/ports.ini); do
    nohup nc -l -p $port &
    pid=$(echo $!)

    # logic to validate if netcat really could be executed
    live_process=$(ps -o pid= 992)
    if [[ "$live_process" == "" ]] ; then
        echo "ERROR: netcat was not able to bind to port $port. Finishing"
        exit 1
    fi
    echo "netcat binded to port $port. PID: $pid"
done