#!/bin/bash

echo "*** Adding Docker repository ..."
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo "*** Installing Docker ..."
sudo dnf update -y && dnf install -y docker-ce docker-ce-cli containerd.io

echo "*** Enable and Start Docker deamon and configuring it to start on boot ..."
sudo systemctl enable docker
sudo systemctl start docker
 
echo "*** Adding vagrant user to the docker group, to be able to work with docker without the need to use always sudo ..."
sudo usermod -aG docker vagrant
