#!/bin/bash

echo "Building with amd64 architecture"
docker buildx build --no-cache --platform linux/amd64 -t zedchance/theia-base:latest .

