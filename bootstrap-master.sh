#!/bin/bash

export https_proxy=https://proxy.houston.hp.com:8080
export http_proxy=http://proxy.houston.hp.com:8080

apt-get update
sudo apt-get install -y unzip python-pip python-dev
sudo pip install ansible

chmod 600 /home/vagrant/.ssh/id_rsa

#ansible-playbook -i ansible/hosts-dev ansible/playbook.yml
