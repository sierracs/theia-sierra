# theia-sierra

Theia IDE Docker images for the Sierra College Computer Science Department.

## `theiactl`

`theiactl` is a helper script that allows you to start/stop containers, reset containers, stop idle containers, and more.

```
theiactl start username wksp   # start a container
theiactl stop username wksp    # stop a container
theiactl rm username wksp      # remove a container
theiactl new-vol username wksp # backup and remove volume (runs rm first)
theiactl pull                  # pull latest image
theiactl ps                    # list all theia containers
theiactl stop-idles            # stop idle containers
theiactl stop-idles -v         # verbose dry run
```
