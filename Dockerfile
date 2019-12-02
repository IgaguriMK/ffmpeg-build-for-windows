FROM ubuntu:18.04
LABEL maintainer "Igaguri <igagurimk@gmail.com>"

# Install build dependencies
RUN apt-get update
RUN apt-get install -y subversion curl texinfo g++ bison flex cvs yasm automake libtool autoconf gcc cmake git make pkg-config zlib1g-dev mercurial unzip pax nasm gperf autogen bzip2 autoconf-archive wget ed

# Create build user
RUN useradd -d /home/builder -m -s /bin/bash builder

# Run with build user
WORKDIR /home/builder

COPY build.sh build.sh
RUN chown builder:builder build.sh && chmod 755 build.sh

COPY known_hosts known_hosts
RUN chown builder:builder known_hosts && chmod 600 known_hosts

WORKDIR /mnt

COPY run.sh run.sh

CMD "./run.sh"
#CMD "/bin/bash"
