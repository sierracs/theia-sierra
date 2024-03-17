#!/bin/bash

ARCH=$(uname -m)
if [ "$1" = "arm" ]; then
	ARCH=aarch64
fi
if [ "$1" = "x86" ]; then
	ARCH=x86_64
fi

docker buildx build --no-cache --platform linux/"$ARCH" -t ubuntu-cs46-$ARCH:dev .
docker tag ubuntu-cs46-$ARCH:dev ubuntu-cs46:dev
