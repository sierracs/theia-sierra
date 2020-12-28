#!/bin/bash

# Build theia-sierra-ubuntu image, defaulting to amd64 arch
if test $# -lt 1
then
    ARCH=$(arch)
else
    ARCH=$1
fi

echo "Building with $ARCH architecture"
docker buildx build --platform linux/$ARCH -t zedchance/theia-sierra-ubuntu:$ARCH .

