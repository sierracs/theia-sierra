#!/bin/bash

# Stop messages
INACTIVE="Changed application state from 'ready' to 'closing_window'"
ERROR="Connection got disposed"

# 30 min timeout
TIMEOUT=1800

# Loop thru running containers
for CONTAINER in $(docker ps --filter ancestor=zedchance/theia-sierra-ubuntu:latest --format "{{.Names}}")
do
    # For each of the last 11 log entries
    docker container logs -t -n 11 "$CONTAINER" | while read -r entry
    do
        # Timestamp is the first 19 chars of the log
        TIMESTAMP=${entry:0:19}

        # Check to see if the log entry is the inactive message
        if [[ $entry == *"$INACTIVE"* || $entry == *"$ERROR"* ]]
        then
            # Current time
            NOW=$(date +%s)

            # Date command on macOS
            # THEN=$(date -jf "%Y-%m-%dT%H:%M:%S" "$TIMESTAMP" "+%s")
            # Date command on linux
            THEN=$(date -d "$TIMESTAMP" +%s)

            # Calculate idle time
            # +28800 to compensate for PST to UTC, fix this
            DIFF=$((NOW - THEN + 28800))
            IDLE_MIN=$((DIFF / 60))

            # Debug
            # echo "Closed container found: $CONTAINER"
            # echo "    Now : $NOW"
            # echo "    Then: $THEN"
            # echo "    Diff: $DIFF"
            # echo "    Log: ${entry:31:100}"
            # echo "    Timestamp: $TIMESTAMP"

            # Check to see if container has timed out
            if [[ $DIFF -gt $TIMEOUT ]]
            then
                echo "$0: $CONTAINER has exceeded time out, stopping..."
                docker stop "$CONTAINER" > /dev/null
            else
                echo "$0: $CONTAINER has been idle for $IDLE_MIN minutes"
            fi

            # Break because we found the inactive/error message
            break
        fi
    done
done

