# Use Arch Linux as the base image
FROM archlinux:latest

# Update the system and install necessary packages
RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm \
    base-devel \
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
    libelf \
    lld \
    llvm \
    ninja \
    openssl \
    python3 \
    uboot-tools \
    && pacman -Scc --noconfirm

# Create the gitpod group with the required GID
RUN groupadd -g 33333 gitpod \
    && useradd -m -u 33333 -g gitpod -s /usr/bin/fish gitpod \
    && echo 'gitpod ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/gitpod \
    && chmod 0440 /etc/sudoers.d/gitpod

USER gitpod
WORKDIR /workspace

# Expose any ports if needed
EXPOSE 3000

# Define default command (if necessary)
CMD ["/usr/bin/fish"]
