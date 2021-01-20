# theia-cs46
# Theia image workspace setup for CS46 class

FROM zedchance/theia-foundation:latest
WORKDIR /
ENV DEBIAN_FRONTEND noninteractive
USER root

# Install CS46 required libs
RUN apt-get update && \
    apt-get -y install cmake \
                       clang \
                       gdb \
                       valgrind \
                       libssl-dev && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# Add welcome message
COPY WELCOME.md /home/

# Theia application
USER theia
WORKDIR /theia
COPY latest.package.json ./package.json

RUN yarn --pure-lockfile && \
    NODE_OPTIONS="--max_old_space_size=4096" yarn theia build && \
    yarn theia download:plugins && \
    yarn --production && \
    yarn autoclean --init && \
    echo *.ts >> .yarnclean && \
    echo *.ts.map >> .yarnclean && \
    echo *.spec.* >> .yarnclean && \
    yarn autoclean --force && \
    yarn cache clean

EXPOSE 3000
ENV SHELL=/bin/bash \
    THEIA_DEFAULT_PLUGINS=local-dir:/theia/plugins

ENTRYPOINT [ "node", "/theia/src-gen/backend/main.js", "/home", "--hostname=0.0.0.0" ]

