# Check for command line arguments
if test $# -lt 2
then
    echo "ERROR: Not enough command line arguments"
    echo "Usage: $0 port_number user_name"
    echo "Example: $0 3000 zed"
    exit 1
fi

# Image
IMAGE=zedchance/theia-sierra-ubuntu

# Command line arguments
PORT=$1
WHOAMI=$2

# Theia user and group ids
USER_ID=1000
GROUP_ID=1000

# Create container and get ID
echo "Creating container from $IMAGE image on port $PORT"
CONTAINER_ID=$(docker create --security-opt seccomp=unconfined --init -it -p 127.0.0.1:$PORT:3000 -u $USER_ID:$GROUP_ID --name $WHOAMI-theia-$PORT $IMAGE)

# Start container
echo "Starting container"
docker start $CONTAINER_ID

# Rename user to specified whoami
echo "Renaming user to $WHOAMI"
docker exec -u root $CONTAINER_ID usermod -l $WHOAMI theia

echo "Copying welcome message"
docker cp WELCOME.md $CONTAINER_ID:/home/project/

