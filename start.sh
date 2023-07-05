#!/bin/bash

envsubst < "MultiplayerSettingsTemplate.json" > "MultiplayerSettings.json"

FORMATED_DATE=$(date '+%Y-%m-%dT%H-%M-%S')
FILE_NAME="/app/PlayFabVmAgentOutput/${FORMATED_DATE}/ExtAssets/SH0/A0/ChainOfAlliance-Server"
echo $FILE_NAME
while [ ! -f $FILE_NAME ]; do 
    sleep 1
    if [ -f $FILE_NAME ]; then 
        chmod -R +x $FILE_NAME
        break
    fi
done &
./LocalMultiplayerAgent