# theia-sierra

Theia IDE Docker images for the CS46 class

### start.sh

This is a helper script that creates a new container then starts it.

It takes 1 command line argument to start the container and add it to `theia-net`:

```
./start name
```

For example:

```
./start zed
```

To test the container it takes 2 arguments, the name and port number to publish:

```
./start name port
```

For example:

```
./start zed 3000
```

