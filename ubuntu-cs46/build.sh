#!/bin/bash

if [ "$1" = "multi"  ]; then
  docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t ubuntu-cs46:dev .
  docker buildx build --load -t ubuntu-cs46:dev  .
else
  docker buildx build -t ubuntu-cs46:dev .
fi
