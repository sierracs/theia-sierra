# ubuntu-cs46

A image based on ubuntu:22.04. It contains all the tools for the CS46 class
to run a CLI environment. Including:

  - clang
  - valgrind
  - libssl
  - cmake

This container can be used to create the same Ubuntu environment that the
corresponding theia-cs46 IDE uses. You can run it as-is, but no files will be
saved. To develop using a directory on the host system, you'll need to mount
it into the container.

    docker run -it \
      --user 2000:2000 \
      --mount src=<path to directory>,dst=/home/cs46 \
      ubuntu-cs46

You will be dropped into a `bash` shell. The mounted directory will be at `/home/cs46`.
