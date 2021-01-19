# theia-sierra

Theia IDE Docker images for the CS46 class

## `theiactl`

`theiactl` is a helper script that allows you to start/stop containers, reset containers, stop idle containers, and more.

Usage:

```
theiactl [start|stop|reset|ps|pull|new-vol|stop-idles]
```

To start a container:

```
theiactl start zed
```

To stop a container:

```
theiactl stop zed
```

To reset a container (stop and remove):

```
theiactl reset zed
```

To view all theia containers:

```
theiactl ps
```

To pull the latest theia image:

```
theiactl pull
```

To backup a container's current volume, then remove it:

```
theiactl new-vol zed
```

To stop idle containers:

```
theiactl stop-idles
```

or if you want to be verbose without stopping them:

```
theiactl stop-idles -v
```

