#!/bin/bash

# Check for command line arguments
if test $# -lt 1
then
    echo "ERROR: Incorrect command line arguments"
    echo "Usage: $0 username [port_number]"
    echo "Example: $0 zed"
    echo "Example: $0 zed 3000"
    exit 1
fi

# Command line arguments
USERNAME=$1
PORT=$2

# Config
USER_ID=1000
GROUP_ID=1000
IMAGE=zedchance/theia-sierra-ubuntu:latest
WKSP=cs46
N=1  # for multiple containers in the future
CONTAINER_NAME=theia-"$USERNAME"-"$WKSP"-"$N"
VOLUME_NAME=vol-"$USERNAME"-"$WKSP"-"$N"

# First check to see if container already exists
if [[ $(docker ps -a --filter "name=$CONTAINER_NAME" --format "{{.Names}}") == $CONTAINER_NAME ]]
then
    echo "Starting $CONTAINER_NAME"
    docker start "$CONTAINER_NAME" > /dev/null
    exit
fi

# Exit on command fail
set -e

# Create container and get ID
if test $# -eq 1
then
    echo "Creating container from $IMAGE, adding to theia-net"
    CONTAINER_ID=$(docker create --security-opt seccomp=unconfined \
                                 --init \
                                 -it \
                                 --mount source="$VOLUME_NAME",target=/home \
                                 --network theia-net \
                                 -u "$USER_ID:$GROUP_ID" \
                                 --name "$CONTAINER_NAME" \
                                 "$IMAGE")
else
    echo "Creating container from $IMAGE on port $PORT"
    CONTAINER_ID=$(docker create --security-opt seccomp=unconfined \
                                 --init \
                                 -it \
                                 --mount source="$VOLUME_NAME",target=/home \
                                 -p 127.0.0.1:"$PORT":3000 \
                                 -u $USER_ID:$GROUP_ID \
                                 --name "$CONTAINER_NAME" \
                                 "$IMAGE")
fi

# Start container
echo "Starting container"
docker start "$CONTAINER_ID"

# Rename user to specified whoami
echo "Renaming user to $USERNAME"
docker exec -u root "$CONTAINER_ID" usermod -l "$USERNAME" theia

# All done
echo "👍"

