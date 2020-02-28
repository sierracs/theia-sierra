# theia-sierra

A Docker image built off of the [theia-cpp-docker](https://github.com/theia-ide/theia-apps/tree/master/theia-cpp-docker) Dockerfile with necessary libraries for CS46 class.

Image contains: `clang`, `gdb`, `valgrind`, `openssl`, `libinetsocket`.

### start.sh

This is a helper script that creates a new container, copies necessary ids over to the container, then starts it.
