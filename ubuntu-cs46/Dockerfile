# theia-foundation Dockerfile (adapted from theia-cpp-docker Dockerfile)

FROM ubuntu:22.04
WORKDIR /
ARG DEBIAN_FRONTEND=noninteractive

ARG GITHUB_TOKEN
ARG NODE_VERSION=20.11.0
ARG YARN_VERSION=1.22.19
ARG LLVM_VERSION=18

# Common deps
RUN <<EOF
apt-get update
apt-get -y install \
	tzdata \
	build-essential \
	sudo \
	curl \
	git \
	lsb-release \
	software-properties-common \
	python3 \
	gpg \
	wget \
	vim \
	nano \
	tmux \
	jq \
	libsecret-1-dev \
	libsecret-1-0 \
	xz-utils
apt-get -y install \
	cmake \
	gdb \
	valgrind \
	netcat \
	libreadline-dev \
	traceroute \
	inetutils-ping \
	libssl-dev
apt-get -y upgrade
# Latest clang
wget https://apt.llvm.org/llvm.sh
echo | bash ./llvm.sh $LLVM_VERSION
for i in clang clang++; do
  ln -s $(readlink /usr/bin/$i-$LLVM_VERSION) /usr/bin/$i
done
rm -f ./llvm.sh
# Clean up
rm -rf /var/lib/apt/lists/*
apt-get clean


# Install Node and Yarn
set -ex
ARCH=
dpkgArch="$(dpkg --print-architecture)"
case "${dpkgArch##*-}" in
    amd64) ARCH='x64';;
    ppc64el) ARCH='ppc64le';;
    s390x) ARCH='s390x';;
    arm64) ARCH='arm64';;
    armhf) ARCH='armv7l';;
    i386) ARCH='x86';;
    *) echo "unsupported architecture"; exit 1 ;;
esac
curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz"
tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner
rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz"
ln -s /usr/local/bin/node /usr/local/bin/nodejs

curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz"
mkdir -p /opt/yarn
tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/yarn --strip-components=1
ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn
ln -s /opt/yarn/bin/yarn /usr/local/bin/yarnpkg
# Clean up
rm yarn-v$YARN_VERSION.tar.gz
EOF

# https://github.com/FooBarWidget/matchhostfsowner
ADD https://github.com/FooBarWidget/matchhostfsowner/releases/download/v1.0.1/matchhostfsowner-1.0.1-x86_64-linux.gz /sbin/matchhostfsowner.gz
COPY --chmod=0700 --chown=0:0 mhf-config.yml /etc/matchhostfsowner/config.yml

# Set up a user
RUN <<EOF
rm -rf /home
addgroup --gid 2000 cs46
adduser --disabled-password --gecos 'CSCI 46 User' --uid 2000 --gid 2000 --home /home cs46
# Allow sudo use without password
echo "%cs46 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# Set timezone
ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

# Set up script to match host username
gunzip /sbin/matchhostfsowner.gz
chown root: /sbin/matchhostfsowner
chmod +x /sbin/matchhostfsowner
EOF

# Add welcome message
COPY --chown=2000:2000 WELCOME.md /home/

#USER cs46
WORKDIR /home

ENTRYPOINT ["/sbin/matchhostfsowner"]
