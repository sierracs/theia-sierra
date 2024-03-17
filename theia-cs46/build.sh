#!/bin/bash

docker buildx build --no-cache --platform linux/x86_64 -t theia-cs46:dev .

