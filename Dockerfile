# Use the Arch Linux base image
FROM archlinux:latest

# Switch to root user for system updates
USER root

# Combine system updates, installation, and user setup in one RUN command
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm sudo base-devel clang lldb llvm fish git binutils ncurses libelf openssl perl rsync tar xz zstd

# sudo hax
RUN useradd -l -u 33333 -G wheel -md /home/gitpod -s /usr/bin/fish -p gitpod gitpod \
    && sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers \
    && chmod 0440 /etc/sudoers

# shell cmd
SHELL ["fish", "--command"]

# set shell use fish
RUN chsh -s /usr/bin/fish

# env fish
ENV SHELL /usr/bin/fish

# entrypoint
ENTRYPOINT [ "fish" ]
