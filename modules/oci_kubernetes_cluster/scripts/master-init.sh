#!/bin/bash

sudo apt-get -y update
sudo apt-get -y install ansible

git clone https://github.com/sigee-min/kubernetes-ansible

sudo chmod 600 /tmp/private.key
sudo cp /tmp/.ansible.cfg ~/.ansible.cfg

cd kubernetes-ansible
git pull

ansible-playbook main.yml -i /tmp/inventory.ini