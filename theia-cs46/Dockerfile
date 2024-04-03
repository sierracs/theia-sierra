# theia-cs46
# Theia image workspace setup for CS46 class

FROM ubuntu-cs46:latest
WORKDIR /
ARG DEBIAN_FRONTEND=noninteractive
USER root

# User account
RUN <<EOF
LOCAL_USER=$(awk -F: '$3 == 2000 { print $1 }' /etc/passwd)
deluser --remove-home $LOCAL_USER
delgroup $LOCAL_USER
addgroup --gid 2000 theia
adduser --disabled-password --gecos '' --home /home --gid 2000 --uid 2000 theia
chmod g+rw /home
# Allow sudo use without password
echo "%theia ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
EOF

# Add welcome message
COPY --chown=2000:2000 WELCOME.md /home/

# Default settings
COPY --chown=2000:2000 settings.json /home/.theia/

# Start script
COPY --chmod=755 theia-entrypoint /theia/theia-entrypoint

# Watchdog script
COPY --chmod=755 watchdog /theia/watchdog

# Theia install location
RUN <<EOF
mkdir -p /theia
chown -R theia:theia /theia
EOF

# Theia application
USER theia
WORKDIR /theia
COPY latest.package.json ./package.json

RUN <<EOF
yarn
yarn theia build
yarn theia download:plugins --ignore-errors
yarn autoclean --init
echo *.ts >> .yarnclean
echo *.ts.map >> .yarnclean
echo *.spec.* >> .yarnclean
yarn autoclean --force
yarn cache clean
rm -rf /home/.cache /home/.npm /home/.yarn
EOF


EXPOSE 3000
ENV SHELL=/bin/bash \
    INIT_CWD=/home \
    PWD=/home \
    THEIA_DEFAULT_PLUGINS=local-dir:/theia/plugins

COPY --chmod=0700 --chown=0:0 mhf-config.yml /etc/matchhostfsowner/config.yml

#USER theia
WORKDIR /home

ENTRYPOINT ["/theia/theia-entrypoint"]
