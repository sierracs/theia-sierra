# Image
IMAGE=theiaide/theia-cpp:next

# Create container and get ID
echo "Creating container"
CONTAINER_ID="$(docker create --security-opt seccomp=unconfined --init -it -p 3000:3000 -u `id -u`:`id -g` -v ~:/home/project:cached $IMAGE)"
echo "CONTAINER_ID: $CONTAINER_ID"

# Copy files from container
echo "Copying passwd and group from container"
docker cp $CONTAINER_ID:/etc/passwd .
docker cp $CONTAINER_ID:/etc/group .

# Copy ids into passwd and group
echo "Adding ids to passwd and group files"
echo "`whoami`:x:`id -u`:`id -g`:,,,:/home/project:/bin/bash" >> passwd
echo "`whoami`:x:`id -g`:" >> group

# Copy files into container
echo "Copying back to container"
docker cp passwd $CONTAINER_ID:/etc/
docker cp group $CONTAINER_ID:/etc/

# Remove files
echo "Removing files"
rm passwd group

# Start container
echo "Starting container"
docker start $CONTAINER_ID

#CONTAINER_ID="$(docker ps -a --format="{{.Names}})"
