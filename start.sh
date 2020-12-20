# Check for command line arguments
if test $# -ne 1
then
    echo "ERROR: Incorrect command line arguments"
    echo "Usage: $0 user_name"
    echo "Example: $0 zed"
    exit 1
fi

# Image
IMAGE=zedchance/theia-sierra-ubuntu

# Command line arguments
WHOAMI=$1

# Theia user and group ids
USER_ID=1000
GROUP_ID=1000

# Create container and get ID
echo "Creating container from $IMAGE image"
CONTAINER_ID=$(docker create --security-opt seccomp=unconfined --init -it --network theia-net -u $USER_ID:$GROUP_ID --name $WHOAMI-theia $IMAGE)

# Start container
echo "Starting container"
docker start $CONTAINER_ID

# Rename user to specified whoami
echo "Renaming user to $WHOAMI"
docker exec -u root $CONTAINER_ID usermod -l $WHOAMI theia

# Add welcome message to container's project dir
echo "Copying welcome message"
docker cp WELCOME.md $CONTAINER_ID:/home/project/

