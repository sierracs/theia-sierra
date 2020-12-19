# theia-sierra

A Docker image built off of the [theia-cpp-docker](https://github.com/theia-ide/theia-apps/tree/master/theia-cpp-docker) Dockerfile with necessary libraries for CS46 class.

Image contains: `clang`, `gdb`, `valgrind`, `libssl`.

### start.sh

This is a helper script that creates a new container, copies necessary ids over to the container, then starts it.

It takes 4 command line arguments:

```
./start port_number user_name
```

For example:

```
./start 3000 zed
```
