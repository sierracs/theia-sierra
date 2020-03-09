# Image
IMAGE=zedchance/theia-sierra-alpine

# Create container and get ID
echo "Creating container from $IMAGE image"
CONTAINER_ID="$(docker create --security-opt seccomp=unconfined --init -it -p 3000:3000 -u `id -u`:`id -g` -v ~:/home/project:cached --name `whoami`-theia $IMAGE)"
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
echo "Removing local files"
rm passwd group

# Start container
echo "Starting container"
docker start $CONTAINER_ID

# Set prompt
echo "Setting prompt files"
docker exec -u root $CONTAINER_ID mv /etc/profile.d/color_prompt /etc/profile.d/color_prompt.sh
docker exec -u root $CONTAINER_ID sed -i -e 's/\\h/\\u/' /etc/profile.d/color_prompt.sh

# Settings
if [ ! -d ~/.theia-storage ]
then
    echo "Making ~/.theia-storage directory with empty settings.json file"
    mkdir ~/.theia-storage
    echo "{}" > ~/.theia-storage/settings.json
fi
echo "Linking settings file"
docker exec -u root $CONTAINER_ID mkdir /home/theia/.theia
docker exec -u root $CONTAINER_ID chown -R `whoami`:`whoami` /home/theia/.theia
docker exec -u root $CONTAINER_ID ln -s /home/project/.theia-storage/settings.json /home/theia/.theia/

#CONTAINER_ID="$(docker ps -a --format="{{.Names}})"
