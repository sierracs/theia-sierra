# Check for command line arguments
if test $# -lt 4
then
    echo "ERROR: Not enough command line arguments"
    echo "Usage: $0 port_number user_name user_id group_id"
    echo "Example: $0 3000 zed 500 20"
    exit 1
fi

# Image
IMAGE=zedchance/theia-sierra-ubuntu

# Command line arguments
PORT=$1
WHOAMI=$2
USER_ID=$3
GROUP_ID=$4

# Create container and get ID
echo "Creating container from $IMAGE image on port $PORT"
CONTAINER_ID=$(docker create --security-opt seccomp=unconfined --init -it -p $PORT:3000 -u $USER_ID:$GROUP_ID --name $WHOAMI-theia-$PORT $IMAGE)
SHORT_ID=$(echo $CONTAINER_ID | head -c 5)
echo "CONTAINER_ID: $SHORT_ID"

# Copy files from container
echo "Copying passwd and group from container"
docker cp $CONTAINER_ID:/etc/passwd .
docker cp $CONTAINER_ID:/etc/group .

# Copy ids into passwd and group
echo "Adding ids to passwd and group files"
echo "$WHOAMI:x:$USER_ID:$GROUP_ID:,,,:/home/project:/bin/bash" >> passwd
echo "$WHOAMI:x:$GROUP_ID:" >> group

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

# Setting permissions
echo "Setting permissions"
docker exec -u root $CONTAINER_ID chown -R $WHOAMI:$WHOAMI /home/project

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
