#!/bin/bash
sudo apt update -y
sudo apt install curl wget net-tools zip -y
#sudo hostnamectl set-hostname ansible-node-1
sudo adduser --disabled-password --gecos "" devops && echo "devops:admin" | sudo chpasswd && echo "devops ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/devops
sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config.d/*.conf
sudo systemctl daemon-reload
sudo systemctl restart ssh
sudo apt install nginx -y
sudo systemctl enable nginx
