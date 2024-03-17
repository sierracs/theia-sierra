# theia-cs39
# Theia image workspace setup for CS39 class

FROM zedchance/theia-foundation-amd64:latest
WORKDIR /
ENV DEBIAN_FRONTEND noninteractive
USER root

# Install CS39 required libs
RUN apt-get update && \
    apt-get -y install gdb-multiarch gcc-arm-linux-gnueabi binutils-arm-linux-gnueabi \
         qemu-user qemu-user-static binutils-arm-linux-gnueabi-dbg && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN ln -s /usr/arm-linux-gnueabi/lib/ld-linux.so.3 /lib && \
    ln -s /usr/arm-linux-gnueabi/lib/libc.so.6 /lib

# Add welcome message and shell customization
COPY WELCOME.md /home/
COPY bash_aliases /home/.bash_aliases

# Theia application
USER theia
WORKDIR /theia
COPY latest.package.json ./package.json

RUN yarn && \
    yarn theia build && \
    yarn theia download:plugins --ignore-errors && \
    yarn autoclean --init && \
    echo *.ts >> .yarnclean && \
    echo *.ts.map >> .yarnclean && \
    echo *.spec.* >> .yarnclean && \
    yarn autoclean --force && \
    yarn cache clean


EXPOSE 3000
ENV SHELL=/bin/bash \
    THEIA_DEFAULT_PLUGINS=local-dir:/theia/plugins

ENTRYPOINT yarn start /home --hostname 0.0.0.0 --port 3000
