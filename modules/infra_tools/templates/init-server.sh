#!/bin/bash

sudo mkdir -p /home/ubuntu/jenkins/home
sudo chmod 777 -R /home/ubuntu/jenkins
sudo chmod 666 /var/run/docker.sock

sudo cp /tmp/docker-compose.yaml /home/ubuntu/docker-compose.yaml
cd /home/ubuntu

docker-compose -f /home/ubuntu/docker-compose.yaml up -d

