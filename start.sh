#!/bin/bash

envsubst < "MultiplayerSettingsTemplate.json" > "MultiplayerSettings.json"

DIR_NAME="/app/PlayFabVmAgentOutput/"
while [ ! -d $DIR_NAME ] && [ ! "$(ls -A $DIR_NAME)" ]; do 
    sleep 1
    
    if [ -d $DIR_NAME ] && [ "$(ls -A $DIR_NAME)" ]; then
        export VM_DIR="/app/PlayFabVmAgentOutput/$(ls $DIR_NAME)/"
        FILE_NAME="${VM_DIR}ExtAssets/SH0/A0/ChainOfAlliance-Server"

        while true; do 
            if [ -f $FILE_NAME ]; then 
                chmod -R +x $FILE_NAME
                break
            fi
            sleep 1
        done
    fi
done &
./LocalMultiplayerAgent
cp -r "${VM_DIR}/GameLogs/449144f3-084b-472f-b8ac-85992ae4b543/PF_ConsoleLogs.txt" "/app/logs"
