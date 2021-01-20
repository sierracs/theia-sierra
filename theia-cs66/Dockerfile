# theia-cs66
# Theia image workspace setup for CS66 class

FROM zedchance/theia-base:latest
WORKDIR /
ENV DEBIAN_FRONTEND noninteractive
USER root

# Install CS66 libs
RUN apt-get update && \
    apt-get -y install cmake \
                       clang \
                       clangd \
                       doxygen \
                       gdb && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# Add welcome message
COPY WELCOME.md /home/

# Theia package.json
WORKDIR /theia
ADD latest.package.json ./package.json

