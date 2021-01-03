# theia-sierra

Theia IDE Docker images for the CS46 class

### start.sh

This is a helper script that starts up a container. If the container doesn't exist it creates it.

It takes 1 command line argument to start the container and add it to `theia-net`:

```
./start name
```

For example:

```
./start zed
```

To test the container locally it takes 2 arguments, the name and port number to publish:

```
./start name port
```

For example:

```
./start zed 3000
```

### stop_idles.sh

This is a script that loops over all running containers and checks their log file.
If the log file indicates that the theia window has been closed, and the timestamp of the log is older than 30 minutes, the container is stopped.

