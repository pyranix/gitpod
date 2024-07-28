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
    && pacman -Scc --noconfirm

# Create the gitpod group with the required GID
RUN groupadd -g 33333 gitpod \
    && useradd -m -u 1000 -g gitpod -s /bin/bash gitpod \
    && echo 'gitpod ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/gitpod \
    && chmod 0440 /etc/sudoers.d/gitpod

USER gitpod
WORKDIR /workspace

# Optional: Install additional tools or dependencies here

# Expose any ports if needed
EXPOSE 3000

# Define default command (if necessary)
CMD ["/bin/bash"]
