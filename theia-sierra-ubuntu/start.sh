# Check for command line arguments
if test $# -eq 0
then
    echo "Usage: ./start port_number"
    echo "Example: ./start 3000"
    exit 1
fi

# Image
IMAGE=zedchance/theia-sierra-glibc

# Port
PORT=$1

# Create container and get ID
echo "Creating container from $IMAGE image on port $PORT"
CONTAINER_ID="$(docker create --security-opt seccomp=unconfined --init -it -p $PORT:$PORT -u `id -u`:`id -g` -v ~:/home/project:cached --name `whoami`-theia $IMAGE)"
SHORT_ID=$(echo $CONTAINER_ID | head -c 5)
echo "CONTAINER_ID: $SHORT_ID"

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
echo "Removing local files"
rm passwd group

# Start container
echo "Starting container"
docker start $CONTAINER_ID

# Settings
# if [ ! -d ~/.theia-storage ]
# then
#     echo "Making ~/.theia-storage directory with empty settings.json file"
#     mkdir ~/.theia-storage
#     echo "{}" > ~/.theia-storage/settings.json
# fi
# echo "Linking settings file"
# docker exec -u root $CONTAINER_ID mkdir -p /home/theia/.theia
# docker exec -u root $CONTAINER_ID chown -R `whoami`:`whoami` /home/theia/.theia
# docker exec -u root $CONTAINER_ID ln -fs /home/project/.theia-storage/settings.json /home/theia/.theia/

#CONTAINER_ID="$(docker ps -a --format="{{.Names}})"
