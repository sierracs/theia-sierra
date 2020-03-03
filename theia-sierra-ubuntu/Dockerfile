# theia-sierra-glibc Dockerfile (adapted from theia-cpp-docker Dockerfile)

FROM ubuntu:18.04
WORKDIR /
ENV DEBIAN_FRONTEND noninteractive

ARG GITHUB_TOKEN
ARG NODE_VERSION=10.15.3
ENV NODE_VERSION $NODE_VERSION
ENV YARN_VERSION 1.13.0

# use "latest" or "next" version for Theia packages
# ARG version=latest
ARG version=sierra

# Optionally build a striped Theia application with no map file or .ts sources.
# Makes image ~150MB smaller when enabled
ARG strip=true
ENV strip=$strip

# Common deps
RUN apt-get update && \
    apt-get -y install curl \
                       git \
                       wget \
                       xz-utils && \
#Install node and yarn
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get install -y nodejs && \
    curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version $YARN_VERSION && \
    export PATH="$PATH:`which yarn`" && \
# C/C++ Developer tools
# install clangd and clang-tidy from the public LLVM PPA (nightly build / development version)
# and also the GDB debugger, cmake from the Ubuntu repos
    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic main" > /etc/apt/sources.list.d/llvm.list && \
    apt-get update && \
    apt-get install -y cmake \
                       clang \
                       clang-tools-11 \
                       clangd-11 \
                       clang-tidy-11 \
                       gdb \
                       valgrind \
                       libssl-dev && \
    ln -s /usr/bin/clangd-11 /usr/bin/clangd && \
    ln -s /usr/bin/clang-tidy-11 /usr/bin/clang-tidy && \
    rm -rf /var/lib/apt/lists/* && \
# Install libinetsocket
    git clone https://github.com/dermesser/libsocket.git && \
    cd libsocket && \
    cmake CMakeLists.txt && \
    make && \
    make install && \
    ldconfig && \
    cd .. && \
    rm -rf libsocket && \
    apt-get clean

# User account
RUN adduser --disabled-password --gecos '' theia
ADD settings.json /home/theia/.theia/
RUN chmod g+rw /home && \
    mkdir -p /home/project && \
    chown -R theia:theia /home/theia && \
    chown -R theia:theia /home/project;

# Theia application
USER theia
WORKDIR /home/theia
ADD $version.package.json ./package.json

RUN if [ "$strip" = "true" ]; then \
yarn --pure-lockfile && \
    NODE_OPTIONS="--max_old_space_size=4096" yarn theia build && \
    yarn theia download:plugins && \
    yarn --production && \
    yarn autoclean --init && \
    echo *.ts >> .yarnclean && \
    echo *.ts.map >> .yarnclean && \
    echo *.spec.* >> .yarnclean && \
    yarn autoclean --force && \
    yarn cache clean \
;else \
yarn --cache-folder ./ycache && rm -rf ./ycache && \
     NODE_OPTIONS="--max_old_space_size=4096" yarn theia build \
;fi

EXPOSE 3000
ENV SHELL=/bin/bash \
    THEIA_DEFAULT_PLUGINS=local-dir:/home/theia/plugins

ENTRYPOINT [ "node", "/home/theia/src-gen/backend/main.js", "/home/project", "--hostname=0.0.0.0" ]
# ENTRYPOINT [ "yarn", "theia", "start", "/home/project", "--hostname=0.0.0.0" ]
