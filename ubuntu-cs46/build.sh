#!/bin/bash

docker buildx build --no-cache --platform linux/amd64,linux/arm64,linux/arm/v7 -t ubuntu-cs46:dev .
docker buildx build --load -t ubuntu-cs46:dev  .
