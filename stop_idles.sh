#!/bin/bash

# Config
INACTIVE="All frontend contributions have been stopped"
TIMEOUT=1800

# Loop thru running containers
for CONTAINER_ID in $(docker ps -q)
do
    # Get latest log entry
    LOG=$(docker container logs -t -n 1 "$CONTAINER_ID")

    # Timestamp is the first 30 chars of the log
    TIMESTAMP=${LOG:0:19}

    # Debug
    # echo "Container ID: $CONTAINER_ID"
    # echo "Log: $LOG"
    # echo "Timestamp: $TIMESTAMP"

    # Check to see if the log entry is the inactive message
    if [[ $LOG == *"$INACTIVE"* ]]
    then
        echo "Closed container found: $CONTAINER_ID"
        NOW=$(date +%s)
        THEN=$(date -jf "%Y-%m-%dT%H:%M:%S" "$TIMESTAMP" "+%s")
        # +28800 to compensate for PST to UTC, fix this
        DIFF=$(expr "$NOW" - "$THEN" + 28800)

        # Debug
        # echo "Now : $NOW"
        # echo "Then: $THEN"
        # echo "Diff: $DIFF"

        if [[ $DIFF -gt $TIMEOUT ]]
        then
            echo "$CONTAINER_ID has exceeded time out, stopping..."
            docker stop $CONTAINER_ID
        else
            IDLE_MIN=$(expr $DIFF / 60)
            echo "$CONTAINER_ID has been idle for $IDLE_MIN minutes"
        fi
    fi
    echo "---"
done

