#! /bin/bash

if [ -d $HOME/development ]; then
  MNTSRC=$HOME/development
elif [ -d $HOME/cs46 ]; then
  MNTSRC=$HOME/cs46
elif [ -d $HOME/container-home ]; then
  MNTSRC=$HOME/container-home
else
  MNTSRC=vol-barrybrown-cs46-1
fi

docker run --rm -it \
	-e MHF_HOST_UID=$(id -u) \
	-e MHF_HOST_GID=$(id -g) \
	--mount type=bind,src=$MNTSRC,dst=/home/cs46 \
	ubuntu-cs46:dev
