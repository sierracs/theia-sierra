# theia-sierra

Theia IDE Dockerfiles for the Sierra College Computer Science Department.

## How to build the images

This repository contains Dockerfiles that build the following images:

- [theia-foundation](https://github.com/zedchance/theia-sierra/tree/master/theia-foundation), the base that the 46 and 66 images are built upon, not directly runnable
- [theia-cs46](https://github.com/zedchance/theia-sierra/tree/master/theia-cs46), the ready-to-run image with libraries installed for the CS46 class
- [theia-cs66](https://github.com/zedchance/theia-sierra/tree/master/theia-cs66), the ready-to-run image with libraries installed for the CS66 class

Each of these directories contains a `build.sh` script that uses the Dockerfile to build an image.
When these `build.sh` scripts are used, it builds an image tagged as `dev`.
This is so you can test the build locally (I usually run them via Docker Desktop, just choose port 3000 when running).
Once you have verified that the new build is working, push a change to the image's `package.json` file to have GitHub build and push a new image tagged `latest`.
See the [.github/workflows](https://github.com/zedchance/theia-sierra/tree/master/.github/workflows) folder to see these actions.

Currently these build scripts use the `amd64` architecture to match the Linode machine that hosts.

## How to update to latest Theia release

The `package.json` file declares what packages get installed in Theia.
When a new Theia release comes out I simply **update the version number in these `packge.json` files** and re-build the image using the build script.
Once you have confirmed that the new image works locally, **push your changes to the `package.json` file to trigger the GitHub action** to build and push the new images to the Docker hub.

See [this commit](https://github.com/zedchance/theia-sierra/commit/d8adfdeb996ea61901d79e09ac1fda9977505554) to get an idea of all that is needed to trigger the GitHub action to build the 46 and 66 images.

> It is worth noting that these images are using `zedchance/theia-foundation` specifically as their base, so they pull the foundation off of Docker hub (see the first `FROM` in the Dockerfiles).
So, if a change is made to the base, make sure to update the version number in `theia-foundation/package.json` and push that change to trigger the GitHub action to build and push the `zedchance/theia-foundation` image.
Then, make any changes to the other images after that new foundation image has been pushed.

## `theiactl`

`theiactl` is a helper script that allows you to start/stop containers, reset containers, stop idle containers, and more.

### Container commands

```
theiactl start username wksp   # start a container, using latest image
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
theiactl ps                    # list all running theia containers
theiactl ps name               # list all containers by name
theiactl stop-idles            # stop idle containers
theiactl stop-idles -v         # verbose dry run
theiactl version               # display version
```

## Some useful commands

List all of the containers, including exited ones:

```
theiactl ps cs
```

List all of the 46 containers:

```
theiactl ps 46
```

Look at the logs of a container:

```
docker logs CONTAINER_NAME
```

Get current Docker storage usage, with a breakdown of each container and volume:

```
docker system df -v
```

`ls` the working directory of a container's volume:

```
docker run --rm -it -v CONTAINER_NAME:/vol alpine ash -c "ls -la /vol"
```

## How to remove all old containers/volumes and prune

I usually run a `docker ps -a` or a `theiactl ps cs` to see what images need to be removed.
Then I run `docker rm` on all of the unwanted containers, then run

```
docker images prune
docker volumes prune
```

to remove all images and volumes that are not associated with a container.
As long as a container exists, these prune commands will not remove their image or volume.

