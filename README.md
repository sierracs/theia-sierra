# theia-sierra

Theia IDE Dockerfiles for the Sierra College Computer Science Department.

## `theiactl`

`theiactl` is a helper script that allows you to start/stop containers, reset containers, stop idle containers, and more.

### Container commands

```
theiactl start username wksp   # start a container
theiactl stop username wksp    # stop a container
theiactl rm username wksp      # remove a container
theiactl state username wksp   # return the state of a container
```

### Volume commands

```
theiactl new-vol username wksp # backup and remove volume (runs rm first)
theiactl recover username wksp # restore contents from backup vol
```

### Other commands

```
theiactl pull                  # pull latest images
theiactl ps                    # list all theia containers
theiactl stop-idles            # stop idle containers
theiactl stop-idles -v         # verbose dry run
theiactl version               # display version
```
