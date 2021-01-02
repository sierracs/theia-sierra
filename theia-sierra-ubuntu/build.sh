#!/bin/bash

# Default to system's arch
ARCH=${1:-$(arch)}

echo "Building with $ARCH architecture"
docker buildx build --platform linux/"$ARCH" -t zedchance/theia-sierra-ubuntu:"$ARCH" .

