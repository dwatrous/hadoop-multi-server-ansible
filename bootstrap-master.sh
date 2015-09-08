#!/bin/bash

export https_proxy=https://proxy.houston.hp.com:8080
export http_proxy=http://proxy.houston.hp.com:8080

apt-get update
apt-get install -y unzip ansible python-virtualenv python-dev

#ansible-playbook -i ansible/hosts-dev ansible/playbook.yml
