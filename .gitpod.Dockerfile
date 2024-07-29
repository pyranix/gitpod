# Use Debian as the base image
FROM debian:latest

# Update the system and install necessary packages
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y \
    build-essential \
    git \
    vim \
    sudo \
    bash-completion \
    fish \
    bc \
    bison \
    ccache \
    clang \
    cpio \
    cmake \
    flex \
    libelf-dev \
    lld \
    llvm \
    ninja-build \
    openssl \
    python3 \
    u-boot-tools \
    && apt-get clean

# Create the gitpod group with the required GID
RUN groupadd -g 33333 gitpod \
    && useradd -m -u 33333 -g gitpod -s /usr/bin/fish gitpod \
    && echo 'gitpod ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/gitpod \
    && chmod 0440 /etc/sudoers.d/gitpod

USER gitpod
WORKDIR /workspace

# Expose any ports if needed
EXPOSE 22

# Define default command (if necessary)
CMD ["/usr/bin/fish"]
