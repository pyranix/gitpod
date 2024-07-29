#!/bin/bash

# Update package list and install OpenSSH server
sudo apt-get update
sudo apt-get install -y openssh-server

# Generate SSH keys if they don't exist
if [ ! -f ~/.ssh/id_rsa ]; then
  ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa
fi

# Print the public key
echo "Add this public key to Termius:"
cat ~/.ssh/id_rsa.pub

# Configure SSH server
sudo mkdir -p /var/run/sshd
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Start SSH server
sudo service ssh start

# Print SSH connection details
echo "SSH server is running."
echo "Connect using the following details:"
echo "Host: $(gp url 22)"
echo "User: gitpod"
echo "Password: <your-gitpod-password>"
