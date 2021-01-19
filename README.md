# theia-sierra

Theia IDE Docker images for the CS46 class

## `theiactl`

`theiactl` is a helper script that allows you to start/stop containers, reset containers, stop idle containers, and more.

```
theiactl start username   # start a container
theiactl stop username    # stop a container
theiactl rm username      # remove a container
theiactl new-vol username # backup and remove volume
theiactl pull             # pull latest image
theiactl ps               # list all theia containers
theiactl stop-idles       # stop idle containers
theiactl stop-idles -v    # verbose dry run
```
